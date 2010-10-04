require 'test_helper'

class ExamTest < ActiveSupport::TestCase
  context "sanitization" do
    setup do
      @old_exam = Factory.create(:exam, :name => "yelp")
      @new_exam = Factory.build( :exam, :name => "<a href=\"http://google.com\">google</a>")
    end
    
    should "save a new record and sanitize the name" do
      assert @new_exam.name == "<a href=\"http://google.com\">google</a>"
      assert @new_exam.save
      assert @new_exam.name == "google"
    end
    
    should "save an old record with a new name" do
      assert @old_exam.name == "yelp"
      @old_exam.name = "<a href=\"http://google.com\">google</a>"
      assert @old_exam.save
      assert @old_exam.name == "google"
    end
  end
end
