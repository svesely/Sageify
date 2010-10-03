class OrganizationsController < ApplicationController
  before_filter :authenticate_user!, :only => [:show]
  before_filter :check_access_control, :except => [:new, :create]

  access_control :allow_access?, :filter => false do
    allow "Managers"
  end
  
  def new
    @organization = Organization.new
    @user = User.new
  end
  
  def create
    @organization = Organization.new(params[:organization])
    @user= User.new(params[:user])
    begin
      ActiveRecord::Base.transaction do
        @organization.save!
        @user.organization = @organization
        @user.save!
        @user.has_role! "Manager"
      end
      flash[:notice] = "Your organization has been added!"
      sign_in_and_redirect(:user, @user)
    rescue 
      flash[:error] = "There were problems saving your information. Please check the form over again"
      render :action => "new"
    end
  end
  
  def show
    @organization = current_user.organization
  end
end
