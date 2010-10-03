class Exam < ActiveRecord::Base
  belongs_to :author, :class_name => "User", :foreign_key => "author_id"
  has_many :questions, :as => :questionable, :order => :position
  has_and_belongs_to_many :lessons
  has_many :assessments
  belongs_to :organization
  before_save :sanitize_name
  
  validates_presence_of :name
  
  def sanitize_name
    self.name = ActionController::Base.helpers.strip_tags(self.name)
  end
  
  def pass_requirement
    attributes["pass_requirement"].nil? ? 0 : attributes["pass_requirement"]
  end
end
