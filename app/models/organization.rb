class Organization < ActiveRecord::Base
  has_many :users
  has_many :lessons
  has_many :exams
  has_many :assessments

  attr_accessible :name
end
