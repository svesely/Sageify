class AssessmentsController < ApplicationController
  before_filter :authenticate_user!
  
  def index
    @exams = current_user.assigned_exams
  end
  
  def show
    @exam = current_user.organization.exams.find(params[:id])
    @assessment = Assessment.new(:exam => @exam)
  end
  
  def create
    @exam = current_user.organization.exams.find(params[:assessment][:exam_id])
    @assessment = Assessment.new(:learner => current_user, :exam => @exam)
    @assessment.organization = current_user.organization
    @assessment.questions = params[:questions]
    respond_to do |format|
      if @assessment.save
        flash[:notice] = 'Assessment successfully completed.'
        format.html { redirect_to(assessments_url) and return }
        format.xml  { render :xml => @exam, :status => :created, :location => @exam }
      else
        format.html { render :action => "show", :id => @exam.id }
        format.xml  { render :xml => @exam.errors, :status => :unprocessable_entity }
      end
    end
  end
end
