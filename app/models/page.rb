class Page < ActiveRecord::Base
  belongs_to :lesson
  belongs_to :organization
  acts_as_list :column => :position, :scope => :lesson
  belongs_to :author, :class_name => "User", :foreign_key => "author_id"
  has_many :questions, :as => :questionable
  before_save :sanitize_title
  
  validates_presence_of :title
  
  after_create :move_to_bottom
  
  def sanitize_title
    self.title = ActionController::Base.helpers.strip_tags(self.title)
  end
  
  def mark_if_compete_for_user(user)
    if self.last?
      user.complete self.lesson
    end
  end
end
