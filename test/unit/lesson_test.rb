require "test_helper"

class LessonTest < Test::Unit::TestCase
  # Replace this with your real tests.
  context "assignments" do
    setup do
      @organization = Factory.create(:organization)
      @lesson = Factory.create(:lesson)
      @unassigned_user = Factory.create(:user)
      @assigned_user = Factory.create(:user)
      @assigned_user.assigned_lessons << @lesson
    end
    #WIP
    # should "know unassigned users" do
    #   assert @lesson.unassigned_users.member?(@unassigned_user)
    # end
    
    should "know assigned users" do
      assert @lesson.assigned_users.member?(@assigned_user)
    end
  end
  
  context "sanitization" do
    setup do
      @old_lesson = Factory.create(:lesson, :name => "yelp")
      @new_lesson = Factory.build( :lesson, :name => "<a href=\"http://google.com\">google</a>")
    end
    
    should "save a new record and sanitize the name" do
      assert @new_lesson.name == "<a href=\"http://google.com\">google</a>"
      assert @new_lesson.save
      assert @new_lesson.name == "google"
    end
    
    should "save an old record with a new name" do
      assert @old_lesson.name == "yelp"
      @old_lesson.name = "<a href=\"http://google.com\">google</a>"
      assert @old_lesson.save
      assert @old_lesson.name == "google"
    end
  end
end
