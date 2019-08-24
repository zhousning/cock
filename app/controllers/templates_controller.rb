class TemplatesController < ApplicationController
  layout "application_control"

   
  def index
    @templates = Template.all
  end
   

   
  def show
    @template = Template.find(params[:id])
  end
   

   
  def new
    @template = Template.new
    
    @template.natures.build
    
    @template.relates.build
    
  end
   

   
  def create
    @template = Template.new(template_params)
    #@template.user = current_user
    if @template.save
      redirect_to @template
    else
      render :new
    end
  end
   

   
  def edit
    @template = Template.find(params[:id])
  end
   

   
  def update
    @template = Template.find(params[:id])
    if @template.update(template_params)
      redirect_to template_path(@template) 
    else
      render :edit
    end
  end
   

   
  def destroy
    @template = Template.find(params[:id])
    @template.destroy
    redirect_to :action => :index
  end
   

  private
    def template_params
      params.require(:template).permit( :name, :nest, :image, :index, :new, :edit, :show, :form, :js, :scss, :admin, natures_attributes: nature_params, relates_attributes: relate_params)
    end
  
  
    def nature_params
      [:id, :name, :title, :tag, :data_type]
    end
  
    def relate_params
      [:id, :relate_type, :obj]
    end
  
end

