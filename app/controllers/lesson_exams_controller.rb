class LessonExamsController < ApplicationController
  before_filter :find_lesson
  def index
  end
  
  def new
    @exams = current_user.organization.exams
  end
  
  def create
    @exam = current_user.organization.exams.find(params[:assignment][:exam_id])
    if @lesson.attach_exam(@exam)
      @lesson.reload
      flash[:notice] = "Exam successfully assigned..."
      redirect_to(lesson_lesson_exams_path(@lesson)) and return
    else
      flash[:notice] = "Please choose a valid exam to assign."
      render :action => :new and return
    end
  end
  
  def destroy
    @exam = current_user.organization.exams.find(params[:id])
    if @lesson.remove_exam(@exam)
      flash[:notice] = "Exam successfully unassigned..."
    else
      flash[:notice] = "This exam could not be properly unassigned. Please contact tech support."
    end
    @lesson.reload
    redirect_to(lesson_lesson_exams_path(@lesson)) and return
  end
  
  private 
  
  def find_lesson
    @lesson = Lesson.find(params[:lesson_id], :include => :assigned_users)
  end
end
