Given /^an organization exists$/ do
  @organization = Organization.find_by_name("Orgrimmarorg")
  @organization ||= Factory.create(:organization)
end

Given /^an instructional designer exists$/ do 
  Given "an organization exists"
  @instructional_designer = Factory.create(:instructional_designer, :email => 'id@example.com', :organization => @organization, :first_name => "Perry", :last_name => "Cox")
  @instructional_designer.has_role! "Instructional Designer"
end

Given /^a learner exists$/ do
  Given "an organization exists"
  @learner = Factory.create(:learner, :email => 'learner@example.com', :organization => @organization, :first_name => "John", :last_name => "Dorian")
end

Given /^a manager exists$/ do 
  Given "an organization exists"
  @manager = Factory.create(:user, :email => 'manager@example.com', :organization => @organization, :first_name => "Bob", :last_name => "Kelso")
  @manager.has_role! "Manager"
end

Given /^I am logged in as an instructional designer$/ do
  Given "an instructional designer exists"
  visit('/login')
  fill_in("user_email", :with => "id@example.com")
  fill_in("user_password", :with => "password")
  click_button('Sign in')
  assert page.has_content?("Signed in successfully")
end

Given /^I am logged in as a learner$/ do
  Given "a learner exists"
  visit('/login')
  fill_in("user_email", :with => "learner@example.com")
  fill_in("user_password", :with => "password")
  click_button('Sign in')
  assert page.has_content?("Signed in successfully")
end

Given /^I (am logged in|log in) as a manager$/ do |how_logged_am_i|
  Given "a manager exists"
  visit('/login')
  fill_in("user_email", :with => "manager@example.com")
  fill_in("user_password", :with => "password")
  click_button('Sign in')
  assert page.has_content?("Signed in successfully")
end

Given /^I am not logged in$/ do 
  ""
end

Given /^a test lesson$/ do
  Factory.create(:test_lesson, :organization => @organization)
end

Given /^I am done viewing Assigned Lesson 1$/ do
  Given "Assigned Lesson 1 has three pages"
  visit('/learn')
  click_link("Assigned Lesson 1")
  click_link("Next")
  click_link("Next")
  page.should_not have_content("Next")
end




