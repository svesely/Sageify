Given /^I have created a lesson$/ do
  Given "I go to the new lesson page"
  fill_in("name", :with => "Test Lesson 1")
  click_button('Create')
end

Given /^I have created a lesson with a few pages$/ do
  @lesson = Factory.create(:test_lesson, :name => 'Test Lesson 1', :organization => @organization)
  3.times do |n|
    Factory.create(:test_page, {:lesson => @lesson, :title => "Test Page #{n}"})
  end
end

Given /^I navigate to the page 2 show$/ do 
  visit('/lessons')
  click_link("Test Lesson 1")
  click_link("Test Page 2")
end

Given /^I navigate to the page 2 edit$/ do
  Given "I navigate to the page 2 show"
  click_link("Edit This Page")
end