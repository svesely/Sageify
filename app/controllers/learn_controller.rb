class LearnController < ApplicationController
  before_filter :authenticate_user!
  
  def index
    @lessons = current_user.organization.lessons.find(:all, :include => :pages)
    respond_to do |format|
      format.html # index.html.erb
    end
  end
  
  def show
    @page = Page.find_by_id_and_organization_id(params[:id], current_user.organization.id)    
    @page.mark_if_compete_for_user(current_user)
    respond_to do |format|
      format.html # show.html.erb
    end
  end
end
