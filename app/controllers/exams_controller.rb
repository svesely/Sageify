class ExamsController < ApplicationController
  before_filter :check_access_control

  access_control :allow_access?, :filter => false do
    allow "Managers"
    allow "Instructional Designers"
  end
  # GET /exams
  # GET /exams.xml
  def index
    @exams = current_user.organization.exams.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @exams }
    end
  end

  # GET /exams/1
  # GET /exams/1.xml
  def show
    @exam = current_user.organization.exams.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @exam }
    end
  end

  # GET /exams/new
  # GET /exams/new.xml
  def new
    @exam = Exam.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @exam }
    end
  end

  # GET /exams/1/edit
  def edit
    @exam = current_user.organization.exams.find(params[:id])
  end

  # POST /exams
  # POST /exams.xml
  def create
    redirect_to(exams_url) and return if params['cancel']
    @exam = Exam.new(params[:exam])
    @exam.organization = current_user.organization

    respond_to do |format|
      if @exam.save
        flash[:notice] = 'Exam was successfully created.'
        format.html { redirect_to(destination_given_params(params)) and return }
        format.xml  { render :xml => @exam, :status => :created, :location => @exam }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @exam.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /exams/1
  # PUT /exams/1.xml
  def update
    redirect_to(exams_url) and return if params['cancel']
    @exam = current_user.organization.exams.find(params[:id])

    respond_to do |format|
      if @exam.update_attributes(params[:exam])
        flash[:notice] = 'Exam was successfully updated.'
        format.html { redirect_to(destination_given_params(params)) and return }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @exam.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /exams/1
  # DELETE /exams/1.xml
  def destroy
    @exam = current_user.organization.exams.find(params[:id])
    @exam.destroy

    respond_to do |format|
      format.html { redirect_to(exams_url) }
      format.xml  { head :ok }
    end
  end
  
  private
    def destination_given_params(params)
      params.keys.any? { |key| key.to_s.downcase =~ /done/ } ? exams_url : new_exam_question_path(@exam)
    end
end
