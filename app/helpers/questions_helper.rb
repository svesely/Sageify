module QuestionsHelper
  def correct_or_not(choice)
    choice.correct? ? "(Correct) " : ""
  end
  def correct_or_not_li(choice)
    "<li>#{choice.letter}. #{correct_or_not(choice)}#{choice.text}</li>"
  end
end
