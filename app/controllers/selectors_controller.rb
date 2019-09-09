class SelectorsController < ApplicationController
  layout "application_control"
  before_filter :authenticate_user!
  load_and_authorize_resource

   
  def index
    @selectors = Selector.all
  end
   

   
  def show
    @selector = Selector.find(params[:id])
  end
   

   
  def new
    @selector = Selector.new
    
  end
   

   
  def create
    @selector = Selector.new(selector_params)
    #@selector.user = current_user
    if @selector.save
      redirect_to @selector
    else
      render :new
    end
  end
   

   
  def edit
    @selector = Selector.find(params[:id])
  end
   

   
  def update
    @selector = Selector.find(params[:id])
    if @selector.update(selector_params)
      redirect_to selector_path(@selector) 
    else
      render :edit
    end
  end
   

   
  def destroy
    @selector = Selector.find(params[:id])
    @selector.destroy
    redirect_to :action => :index
  end
   

  private
    def selector_params
      params.require(:selector).permit( :name, :file, :title)
    end
  
  
end

