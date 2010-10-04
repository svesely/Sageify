class PagesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :check_access_control

  access_control :allow_access?, :filter => false do
    allow "Instructional Designers"
    allow "Managers"
  end
  
  #TODO dry this mofo out.
  #TODO also, probably put some security around here. 
  def sort
    @page = Page.find(params[:page_id])
    case params[:direction]
    when "up"
      @page.move_higher
    when "down"
      @page.move_lower
    end
    redirect_to :back
  end
  
  def index
    @lesson = Lesson.find(params[:lesson_id], :include => :pages)
  end
      
  def new
    @lesson = Lesson.find(params[:lesson_id])
    @page = @lesson.pages.new
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @page }
    end
  end
  
  def show
    @page = Page.find(params[:id])
    @lesson = @page.lesson
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @page }
    end
  end
  
  def create
    @lesson = Lesson.find(params[:lesson_id])
    @page = Page.new(params[:page])
    @page.organization = current_user.organization
    @page.lesson = @lesson
    redirect_to(@lesson)  and return if params['cancel']
    respond_to do |format|
      if @page.save
        flash[:notice] = 'Page was successfully created.'
        format.html { redirect_to(destination_given_params(params)) and return }
        format.xml  { render :xml => @page, :status => :created, :location => @page }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @page.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def update
    
    
    @lesson = Lesson.find(params[:lesson_id])
    @page = Page.find(params[:id])
    redirect_to(@lesson) and return if params['cancel']
    respond_to do |format|
      if @page.update_attributes(params[:page])
        flash[:notice] = 'Page was successfully updated.'
        format.html { redirect_to(destination_given_params(params)) and return }
        format.xml  { render :xml => @page, :status => :created, :location => @page }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @page.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def edit
    @page = Page.find(params[:id])
    @lesson = @page.lesson
  end
  
  private
    def destination_given_params(params)
      case 
      when params['save_and_done'] 
        @lesson
      when params['save_and_add_another']
        new_lesson_page_path(@lesson)
      else
        [@lesson, @page]
      end
    end
end


