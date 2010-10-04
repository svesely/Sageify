require 'test_helper'

class PageTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  context "sanitization" do
    setup do
      @old_page = Factory.create(:test_page, :title => "yelp")
      @new_page = Factory.build( :test_page, :title => "<a href=\"http://google.com\">google</a>")
    end
    
    should "save a new record and sanitize the title" do
      assert @new_page.title == "<a href=\"http://google.com\">google</a>"
      assert @new_page.save
      assert @new_page.title == "google"
    end
    
    should "save an old record with a new title" do
      assert @old_page.title == "yelp"
      @old_page.title = "<a href=\"http://google.com\">google</a>"
      assert @old_page.save
      assert @old_page.title == "google"
    end
  end
end
