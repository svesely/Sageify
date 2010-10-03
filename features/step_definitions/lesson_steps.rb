Given /^Assigned Lesson 1 exists$/ do
  Given "an organization exists"
  @lesson = Factory.create(:assigned_lesson_1, :organization => @organization)
  @lesson.assign(User.find_by_email('learner@example.com'))
  @lesson.reload
end

Given /^Unassigned Lesson 1 has an exam$/ do
  Given "Unassigned Lesson 1 exists"
  Given "an old exam"
  @lesson.exams << @exam
  @lesson.reload
end

Given /^Assigned Lesson 1 has an exam$/ do
  Given "Assigned Lesson 1 exists"
  Given "an old exam"
  @lesson.exams << @exam
  @lesson.reload
end

Given /^no lessons exist$/ do
  Lesson.delete_all
end

Given /^Assigned Page 1 exists$/ do 
  Factory.create(:assigned_page_1, :position => 1)
end

Given /^Assigned Lesson 1 has three pages$/ do 
  Given "Assigned Lesson 1 exists"
  lesson = Lesson.find_by_name('Assigned Lesson 1')
  (1..3).each do |n|
    page = Factory.create(:assigned_page_1, :content => "You are viewing Assigned Page #{n}!", :lesson => lesson, :organization => @organization  )
    page.move_to_bottom
  end
end

Given /^Unassigned Lesson 1 exists$/ do
  @lesson = Factory.create(:test_lesson, :name => 'Unassigned Lesson 1', :organization => @organization)
end