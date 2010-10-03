class Lesson < ActiveRecord::Base
  belongs_to :lessonable, :polymorphic => true
  acts_as_list :column => :position, :scope => :lessonable
  acts_as_authorization_object
  belongs_to :author, :class_name => "User", :foreign_key => "author_id"
  has_many :lessons, :as => :lessonable
  has_many :pages, :order => :position
  has_many :assignments
  has_many :assigned_users, :through => :assignments, :source => :user
  has_many :completions
  has_many :completed_users, :through => :completions, :source => :user
  has_and_belongs_to_many :exams
  belongs_to :organization
  before_save :sanitize_name
  
  validates_presence_of :name
  
  def sanitize_name
    self.name = ActionController::Base.helpers.strip_tags(self.name)
  end
  
  def is_attached_exam?(exam)
    self.exams.member?(exam)
  end
  
  def unassigned_users
    self.organization.users.find(:all, :conditions => ["users.id not in (select user_id from assignments where lesson_id = ?)", self.id])
  end
  
  def attach_exam(exam)
    raise ArgumentError unless exam.is_a? Exam
    return false if self.is_attached_exam?(exam)
    self.exams << exam
    return true
  end
  
  def remove_exam(exam)
    raise ArgumentError unless exam.is_a? Exam
    self.exams.delete(exam)
  end
  
  def completed_by!(user)
    user.complete(self)
  end
  
  def assign(user)
    user.assign(self)
  end
  
  def first_page
    self.pages.first
  end
  
  def last_page
    self.pages.last
  end
  
  def all_child_lessons
    if self.lessons.empty? 
      return self
    else
      return [self.lessons.map { |lesson| lesson.all_child_lessons}, self ].flatten
    end
  end
end
