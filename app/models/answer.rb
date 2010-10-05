class Answer < ActiveRecord::Base
  belongs_to :question
  belongs_to :assessment

  attr_accessible :value, :correct
  
  def correct?
    self.question.correct_choice.letter == self.value.to_s.downcase
  end
  
end
