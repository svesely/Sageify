class Question < ActiveRecord::Base
  attr_accessor :correct_choice_letter
  
  belongs_to :questionable, :polymorphic => true
  has_many :choices, :dependent => :destroy
  belongs_to :correct_choice, :class_name => "Choice", :foreign_key => "correct_choice_id"
  has_many :answers 
  
  acts_as_list :column => :position, :scope => :questionable
  
  before_validation :update_correct_choice

  accepts_nested_attributes_for :choices, :allow_destroy => true, :reject_if => proc { |attrs|  attrs['text'].strip.blank? }
  
  validates_presence_of :text, :message => "can't be blank"
  validates_presence_of :correct_choice, :on => :create, :message => "You must select a correct choice"
  validates_associated :correct_choice, :on => :create
  
  def calculated_range(range)
    if range.nil?
      ("a".."e")
    elsif range.is_a?(Range)
      range
    else
      raise "Incompatible Range"
    end
  end
  
  def build_possible_choices(range = nil)
    calculated_range(range).each do |letter|
      self.choices.build(attributes = {:letter => letter}) if choice_for_letter(letter).nil?
    end
    self.choices
  end
  
  def choice_for_letter(letter)
    self.choices.detect { |choice| choice.letter.downcase == letter.downcase }
  end
  
  def update_correct_choice
    self.correct_choice = self.choice_for_letter(self.correct_choice_letter)
  end
  
end
