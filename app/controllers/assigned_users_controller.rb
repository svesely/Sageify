class AssignedUsersController < ApplicationController
  
  before_filter :find_lesson
  
  def index
  end
  
  def new
    @users = current_user.organization.users
  end
  
  def create
    @user = current_user.organization.users.find(params[:assignment][:user_id])
    if @lesson.assign(@user)
      @lesson.reload
      flash[:notice] = "User successfully assigned..."
      redirect_to(lesson_assigned_users_path(@lesson)) and return
    else
      flash[:notice] = "Please choose a valid user to assign."
      render :action => :new and return
    end
  end
  
  def destroy
    @user = current_user.organization.users.find(params[:id])
    if @user.unassign(@lesson)
      flash[:notice] = "User successfully unassigned..."
    else
      flash[:notice] = "This user could not be properly unassigned. Please contact tech support."
    end
    @lesson.reload
    redirect_to(lesson_assigned_users_path(@lesson)) and return
  end
  
  private 
  
  def find_lesson
    @lesson = current_user.organization.lessons.find(params[:lesson_id], :include => :assigned_users)
  end
end
