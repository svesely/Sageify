class QuestionsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :check_access_control

  access_control :allow_access?, :filter => false do
    allow "Instructional Designers"
    allow "Managers"
  end
  
  # GET /questions
  # GET /questions.xml
  # def index
  #   @questions = Question.all
  # 
  #   respond_to do |format|
  #     format.html # index.html.erb
  #     format.xml  { render :xml => @questions }
  #   end
  # end

  # GET /questions/1
  # GET /questions/1.xml
  def show
    @question = Question.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @question }
    end
  end

  # GET /questions/new
  # GET /questions/new.xml
  def new
    @exam = current_user.organization.exams.find(params['exam_id'])
    @question = @exam.questions.build
    @question.build_possible_choices
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @question }
    end
  end

  # GET /questions/1/edit
  def edit
    @question = Question.find(params[:id])
  end

  # POST /questions
  # POST /questions.xml
  def create
    @exam = current_user.organization.exams.find(params['exam_id'])
    @question = @exam.questions.new(params[:question])
    @question.correct_choice_letter = params[:question][:correct_choice_letter]
    redirect_to(@question.questionable)  and return if params['cancel']
    respond_to do |format|
      if @question.save
        flash[:notice] = 'Question was successfully created.'
        format.html { redirect_to(destination_given_params(params)) and return }
        format.xml  { render :xml => @question, :status => :created, :location => @question }
      else
        @question.build_possible_choices
        format.html { render :action => "new" }
        format.xml  { render :xml => @question.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /questions/1
  # PUT /questions/1.xml
  def update
    @question = Question.find(params[:id])

    respond_to do |format|
      if @question.update_attributes(params[:question])
        flash[:notice] = 'Question was successfully updated.'
        format.html { redirect_to(@question) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @question.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /questions/1
  # DELETE /questions/1.xml
  def destroy
    @question = Question.find(params[:id])
    @question.destroy

    respond_to do |format|
      format.html { redirect_to(questions_url) }
      format.xml  { head :ok }
    end
  end
  
  private
    def destination_given_params(params)
      case 
      when params['save_and_done'] 
        @exam
      when params['save_and_new']
        new_exam_question_path(@exam)
      else
        [@exam, @question]
      end
    end
end
