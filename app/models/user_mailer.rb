class UserMailer < ActionMailer::Base
  default :from => "Sageify Notifications <do_not_reply@sageify.com>"

  def welcome_email(user, password)
    @user = user
    @password = password
    @url = "http://sageify.com/login"
    mail(
      :to => user.email, 
      :subject => "Welcome to Sageify!",
    )
  end
  
  def lesson_assigned_email(user, lesson)
    @user = user
    @lesson = lesson
    @url = "http://sageify.com/login"
    mail(
      :to => user.email,
      :subject => "New Lesson Assignment!"
    )
  end
end
