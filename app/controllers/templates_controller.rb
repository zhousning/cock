class TemplatesController < ApplicationController
  layout "application_control"
  #load_and_authorize_resource

   
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

  def produce
    @template = Template.find(params[:id])
    @natures = @template.natures

    cond = "rails g item " + @template.name + " "

    unless @natures.blank?
      nature_str = ""
      label = "-l "
      tag = "-t "
      @natures.each do |nature|
        nature_str += nature.name + ":" + nature.data_type + " "
        label += nature.title + " "
        tag += nature.tag + " "
      end
      cond += nature_str + label + tag + " "
    end

    cond += "-n " + @template.cn_name + " " + 
           "-i " + @template.image.to_s + " " +
           "-x " + @template.index.to_s + " " +
           "-w " + @template.new.to_s + " " +
           "-e " + @template.edit.to_s + " " +
           "-h " + @template.show.to_s + " " +
           "-r " + @template.form.to_s + " " +
           "-j " + @template.js.to_s + " " +
           "-c " + @template.scss.to_s + " " +
           "-a " + @template.admin.to_s + " "

    cond += "-z " + @template.nest + " " unless @template.nest.blank?

    @relates = @template.relates
    unless @relates.blank?
      cond += "-y "
      @relates.each do |relate|
        cond += relate.relate_type + ":" + relate.obj + " "
      end
    end
    puts cond
    exec cond
    redirect_to template_path(@template) 
  end
   

   
  def destroy
    @template = Template.find(params[:id])
    @template.destroy
    redirect_to :action => :index
  end
   

  private
    def template_params
      params.require(:template).permit( :name, :cn_name, :nest, :image, :index, :new, :edit, :show, :form, :js, :scss, :admin, natures_attributes: nature_params, relates_attributes: relate_params)
    end
  
  
    def nature_params
      [:id, :name, :title, :tag, :data_type]
    end
  
    def relate_params
      [:id, :relate_type, :obj]
    end
  
end

