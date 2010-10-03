module ScoresHelper
  def correct?(choice)
    choice.correct? ? "Correct" : nil
  end
  
  def selected?(choice, answer)
    answer.value == choice.letter ? "Selected" : nil
  end
  
  def correct_and_selected(choice, answer)
    return "(#{[correct?(choice), selected?(choice, answer)].compact.join(", ")})" unless correct?(choice).blank? && selected?(choice, answer).blank?
  end
  
  def show_correct_selected_choice(choice, answer) 
    "#{choice.letter}. #{correct_and_selected(choice, answer)} #{choice.text}"
  end
end
