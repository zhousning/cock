class RelatesController < ApplicationController
  layout "application_control"

   
  def index
    @relates = Relate.all
  end
   

   
  def show
    @relate = Relate.find(params[:id])
  end
   

   
  def new
    @relate = Relate.new
    
  end
   

   
  def create
    @relate = Relate.new(relate_params)
    #@relate.user = current_user
    if @relate.save
      redirect_to @relate
    else
      render :new
    end
  end
   

   
  def edit
    @relate = Relate.find(params[:id])
  end
   

   
  def update
    @relate = Relate.find(params[:id])
    if @relate.update(relate_params)
      redirect_to relate_path(@relate) 
    else
      render :edit
    end
  end
   

   
  def destroy
    @relate = Relate.find(params[:id])
    @relate.destroy
    redirect_to :action => :index
  end
   

  private
    def relate_params
      params.require(:relate).permit( :type, :obj)
    end
  
  
end

