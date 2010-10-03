Given /^three exams exist$/ do
  Given "an organization exists"
  instructional_designer = Factory.create(:instructional_designer)
  Factory.create(:exam, :author => instructional_designer, :organization => @organization)
  Factory.create(:exam, :author => instructional_designer, :organization => @organization)
  Factory.create(:exam, :author => instructional_designer, :organization => @organization)
end

Given /^an old exam$/ do
  Given "an organization exists"
  @exam = Factory.create(:exam, :name => "This old exam", :organization => @organization)
end

Given /^an exam with questions$/ do
  Given "an organization exists"
  exam = Factory.create(:exam, :name => "Big exam", :organization => @organization)
  (1..3).each do |n|
    question = Factory.build(:question, :text => "Question #{n}")
    question.choices.build( attributes = {:letter => "a", :text => "An answer"})
    question.choices.build( attributes = {:letter => "b", :text => "Correct answer"})
    question.choices.build( attributes = {:letter => "c", :text => "Another answer"})
    question.correct_choice_letter = "b"
    question.save
    exam.questions << question
  end
end

Given /^a learner has taken an exam$/ do
  learner = User.find_by_email("learner@example.com")
  Given "an exam with questions"
  exam = Exam.find_by_name("Big exam")
  assessment = learner.assessments.new
  assessment.organization = @organization
  assessment.exam = exam
  assessment.questions = ["a", "b", "b"]
  assessment.save
end

