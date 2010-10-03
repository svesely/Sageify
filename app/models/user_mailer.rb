class UserMailer < ActionMailer::Base
  def welcome_email(user, password)
    recipients    user.email
    from          "Sageify Notifications <do_not_reply@sageify.com>"
    subject       "Welcome to Sageify!"
    sent_on       Time.now
    body          :user => user, :url => "http://sageify.com/login", :password => password
  end
  
  def lesson_assigned_email(user, lesson)
    recipients    user.email
    from          "Sageify Notifications <do_not_reply@sageify.com>"
    subject       "New Lesson Assignment!"
    sent_on       Time.now
    body          :user => user, :url => "http://sageify.com/login", :lesson => lesson
  end
end
