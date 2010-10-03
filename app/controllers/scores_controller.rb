class ScoresController < ApplicationController
  before_filter :authenticate_user!
  before_filter :check_access_control

  access_control :allow_access?, :filter => false do
    allow "Managers"
  end
  
  def index
    @scores = current_user.organization.assessments.find(:all, :limit => 20, :order => ["created_at desc"])
  end
  
  def show
    @score = current_user.organization.assessments.find(params[:id])
  end
end
