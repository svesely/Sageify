# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all
  protect_from_forgery :secret => "1OlbmzDdcwfiYKxfeAKnDq4WTglo3BpvC3OR581UnzOvkGGnwDozG6HiPP3tZUJN"
  private  
    
    def after_sign_in_path_for(user)
      if user.has_role?('Instructional Designer')
        lessons_url
      elsif user.has_role?('Learner')
        learn_index_url
      else
        lessons_url
      end
    end

    def store_location
      session[:return_to] = request.request_uri
    end
    
    def redirect_back_or_default(default)
      redirect_to(session[:return_to] || default)
      session[:return_to] = nil
    end
    
    def check_access_control
      if allow_access?
        return true
      else
        respond_to do |format|
          format.html { render :template => "users/access_denied" }
          format.xml  { render :status => :access_denied }
        end
        return false
      end
    end
end
