Given /^I have been assigned a lesson with an exam$/ do
  Given "Assigned Lesson 1 exists"
  lesson = Lesson.find_by_name('Assigned Lesson 1')
  exam =  Factory.create(:exam, :name => "Available assessment", :organization => @organization)
  question = Factory.build(:question, :text => "Question, the first")
  question.choices << Factory.create(:choice, :text => "Choice, the first", :letter => "a")
  question.choices << Factory.create(:choice, :text => "Choice, the second", :letter => "b")
  question.correct_choice_letter = "b"
  question.save
  exam.questions << question
  question = Factory.build(:question, :text => "Question, the second")
  question.choices << Factory.create(:choice, :text => "Choice, the first", :letter => "a")
  question.choices << Factory.create(:choice, :text => "Choice, the second", :letter => "b")
  question.correct_choice_letter = "a"
  question.save
  exam.questions << question
  lesson.exams << exam
end

