# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all
  protect_from_forgery :secret => "1OlbmzDdcwfiYKxfeAKnDq4WTglo3BpvC3OR581UnzOvkGGnwDozG6HiPP3tZUJN"
  private  
    # def current_user_session
    #   return @current_user_session if defined?(@current_user_session)
    #   @current_user_session = UserSession.find
    # end
    # 
    # def current_user
    #   return @current_user if defined?(@current_user)
    #   @current_user = current_user_session && current_user_session.record
    # end
    # 
    # def require_user
    #   unless current_user
    #     store_location
    #     flash[:notice] = "You must be logged in to access this page" unless request.path_info == '/' 
    #     redirect_to root_url
    #     return false
    #   end
    # end
 
    # def require_no_user
    #   if current_user
    #     store_location
    #     flash[:notice] = "You must be logged out to access this page"
    #     redirect_to "/"
    #     return false
    #   end
    # end
    
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

    def default_for_user(user)
      #TODO this sucks
      if user.has_role?('Instructional Designer')
        root_url
      elsif user.has_role?('Learner')
        learn_index_url
      else
        root_url
      end
    end
end
