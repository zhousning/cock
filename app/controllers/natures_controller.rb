class NaturesController < ApplicationController
  layout "application_control"

   
  def index
    @natures = Nature.all
  end
   

   
  def show
    @nature = Nature.find(params[:id])
  end
   

   
  def new
    @nature = Nature.new
    
  end
   

   
  def create
    @nature = Nature.new(nature_params)
    #@nature.user = current_user
    if @nature.save
      redirect_to @nature
    else
      render :new
    end
  end
   

   
  def edit
    @nature = Nature.find(params[:id])
  end
   

   
  def update
    @nature = Nature.find(params[:id])
    if @nature.update(nature_params)
      redirect_to nature_path(@nature) 
    else
      render :edit
    end
  end
   

   
  def destroy
    @nature = Nature.find(params[:id])
    @nature.destroy
    redirect_to :action => :index
  end
   

  private
    def nature_params
      params.require(:nature).permit( :name, :type, :title, :tag)
    end
  
  
end

