class UsersController < ApplicationController
  before_filter :authenticate_user!
  before_filter :check_access_control
  
  access_control :allow_access?, :filter => false do
    allow "Managers"
    allow "Instructional Designers"
  end
  
  def index
    @users = current_user.organization.users.find(:all)
  end
  
  def new
    @user = current_user.organization.users.new
  end
  
  def create
    @user = current_user.organization.users.new(params[:user])
    @user.email = params[:user][:email]
    @user.password = params[:user][:password]
    @user.password_confirmation = params[:user][:password_confirmation]
    if @user.email_and_save
      @user.adjust_roles_for_params(params) if current_user.has_role? "Manager"
      flash[:notice] = "User Created!"
      redirect_to users_url
    else
      render :action => :new
    end
  end
  
  def show
    @user = current_user.organization.users.find(params[:id])
  end
 
  def edit
    @user = current_user.organization.users.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      @user.adjust_roles_for_params(params) if current_user.has_role?("Manager")
      flash[:notice] = "User updated!"
      redirect_to users_url
    else
      render :action => :edit
    end
  end
end
