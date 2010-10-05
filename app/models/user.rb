class User < ActiveRecord::Base
  devise :database_authenticatable, :rememberable, :trackable
  acts_as_authorization_subject  
  has_many :authored_lessons, :class_name => "Lesson", :foreign_key => "author_id"
  has_many :assignments
  has_many :assigned_lessons, :through => :assignments, :source => :lesson
  has_many :completions
  has_many :completed_lessons, :through => :completions, :source => :lesson
  has_many :assessments, :class_name => "Assessment", :foreign_key => "learner_id"
  has_many :exams, :class_name => "Exam", :foreign_key => "author_id"
  belongs_to :organization
  
  validates_associated :organization, :on => :create
  validates :first_name, :presence => true
  validates :last_name, :presence => true
  validates :password, :presence => true, :length => { :within => 6..20 }
  validates :email, :presence => true, :length => {:within => 4..50 }

  attr_accessible :first_name, :last_name
  
  def email_and_save
    temporary_password = random_password
    self.password = temporary_password
    self.password_confirmation = temporary_password
    if self.save
      UserMailer.welcome_email(self, temporary_password).deliver
    end
  end
  
  def first_name
    return nil if attributes["first_name"].nil?
    if attributes["first_name"] == attributes["first_name"].downcase
      attributes["first_name"].capitalize
    else
      attributes["first_name"]
    end
  end
  
  def first_name_or_email
    first_name.nil? ? self.email : self.first_name
  end
  
  def last_name
    return nil if attributes["last_name"].nil?
    if attributes["last_name"] == attributes["last_name"].downcase
      attributes["last_name"].capitalize
    else
      attributes["last_name"]
    end
  end
  
  def display_name
    "#{first_name} #{last_name} (#{role})"
  end
  
  def is_assigned?(lesson)
    Assignment.exists?({:lesson_id => lesson.id, :user_id => self.id})
  end
  
  def has_completed?(lesson)
    Completion.exists?({:lesson_id => lesson.id, :user_id => self.id})
  end
  
  def assign(lesson)
    raise ArgumentError unless lesson.is_a? Lesson
    return false if self.is_assigned?(lesson)
    assignment = self.assignments.new
    assignment.lesson = lesson
    assignment.save
    UserMailer.lesson_assigned_email(self, lesson).deliver
  end
  
  def complete(lesson)
    raise ArgumentError unless lesson.is_a? Lesson
    self.completed_lessons << lesson
    self.unassign lesson
    self.save
  end
  
  def unassign(lesson)
    raise ArgumentError unless lesson.is_a? Lesson
    return self.assigned_lessons.delete(lesson)
  end
  
  def assigned_root_lessons
    roles.find(:all, {:conditions => {:authorizable_type => 'Lesson', :name => 'assignee'}}).collect {|role| role.authorizable}
  end
  
  def assigned_exams
    assigned_lessons.map {|lesson| lesson.exams }.flatten
  end
  
  def adjust_roles_for_params(params)
    if params["manager"]
      self.has_role! "Manager"
    else
      self.has_no_role! "Manager"
    end
    if params["instructional_designer"]
      self.has_role! "Instructional Designer"
    else
      self.has_no_role! "Instructional Designer"
    end
  end
  
  def is_editable_by_user?(editing_user)
    return true if self === editing_user
    return false if self.organization_id != editing_user.organization_id
    #TODO unmessy this
    if editing_user.role == "Manager"
      return true
    elsif editing_user.role == "Instructional Designer"
      if self.role == "Learner"
        return true
      else
        return false
      end
    else
      return false
    end
  end
  
  def role
    if self.has_role?("Manager")
      "Manager"
    elsif self.has_role?("Instructional Designer")
      "Instructional Designer"
    else
      "Learner"
    end
  end
  
  private
  def random_password
    Base64.encode64(Digest::SHA1.digest("#{rand(1<<64)}/#{Time.now.to_f}/#{Process.pid}"))[0..7]
  end
end
