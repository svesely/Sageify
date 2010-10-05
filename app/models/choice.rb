class Choice < ActiveRecord::Base
  belongs_to :question

  attr_accessible :text, :letter
	
  def correct?
    self.question.correct_choice_id == self.id
  end
	
	def <=>(other_choice)
	  return 0 if self.letter.blank? 
	  return 1 if other_choice.letter.blank?
	  self.letter <=> other_choice.letter
  end



end
