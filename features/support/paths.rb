module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name
    
    when /the home\s?page/
      '/'

    when /the new page page/
      new_page_path

    when /the new learner page/
      new_learner_path

    when /the new lesson page/
      new_lesson_path

    when /the lessons page/
      lessons_path

    when /the learn page/
      '/learn'

    when /the exams page/
      '/exams'

    when /new exam page/
      '/exams/new'

    when /the assessments page/
      '/assessments'

    when /the scores page/
      '/scores'

    when /the signup page/
      '/signup'

    when /the new user page/
      '/users/new'

    when /the users page/
      '/users'

    when /the organization page/
      organization_path
    
    # Add more mappings here.
    # Here is an example that pulls values out of the Regexp:
    #
    #   when /^(.*)'s profile page$/i
    #     user_profile_path(User.find_by_login($1))

    else
      raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
        "Now, go and add a mapping in #{__FILE__}"
    end
  end
end

World(NavigationHelpers)
