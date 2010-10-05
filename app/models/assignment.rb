class Assignment < ActiveRecord::Base
  belongs_to :user
  belongs_to :lesson

  attr_accessible
end
