Factory.define :organization do |o|
  o.name "Orgrimmarorg"
end

Factory.define :user do |o|
  o.password "password"
  o.password_confirmation "password"
  o.sequence(:email) {|n| "person#{n}@example.com" }
  o.sequence(:single_access_token) {|n| "k3cFzLIQnZ4MHRmJvJz#{n}" }
  o.association :organization, :factory => :organization
end

Factory.define :instructional_designer, :parent => :user do |o|
  o.sequence(:email) {|n| "instructional_designer_#{n}@example.com"}
end

Factory.define :manager, :parent => :user do |o|
  o.sequence(:email) {|n| "manager_#{n}@example.com"}
end

Factory.define :learner, :parent => :user do |o|
  o.sequence(:email) {|n| "learner_#{n}@example.com"}
end

Factory.define :lesson, :class => :lesson do |o|
  o.sequence(:name) {|n| "Lesson #{n}"}
  o.author_id {|a| a.association(:instructional_designer)}
  o.association :organization, :factory => :organization
end

Factory.define :test_lesson, :parent => :lesson do |o|
  o.sequence(:name) {|n| "Test Lesson #{n}"}
  o.author_id {|a| a.association(:instructional_designer)}
end

Factory.define :assigned_lesson_1, :class => :lesson do |o|
  o.name "Assigned Lesson 1"
  o.author_id {|a| a.association(:instructional_designer)}
end

Factory.define :assigned_page_1, :class => :page do |o|
  o.title 'Assigned Page 1'
  o.content 'h1. Welcome to Assigned Lesson 1'
  o.association :lesson, :factory => :assigned_lesson_1
end

Factory.define :test_page, :class => :page do |o|
  o.sequence(:title) {|n| "Test Page #{n}"}
  o.sequence(:content) {|n| "h1. This is my content for test page #{n}"}
  o.association :lesson, :factory => :test_lesson
end

Factory.define :exam do |o|
  o.sequence(:name) {|n| "Exam #{n}"}
  o.pass_requirement 70
  o.association :author, :factory => :instructional_designer
end

Factory.define :question do |o|
  o.sequence(:text) {|n| "Question #{n}"}
  o.correct_choice_letter "b"
end

Factory.define :assessment do |o|
  o.association :exam, :factory => :exam
  o.association :learner, :factory => :learner
end

Factory.define :correct_answer, :class => :answer do |o|
  o.association :question, :factory => :question
  o.association :assessment, :factory => :assessment
  o.value "b"
end
  
Factory.define :incorrect_answer, :parent => :correct_answer do |o|
  o.value "a"
end

Factory.define :choice do |o|
  o.text "this is choice a"
  o.letter "a"
end