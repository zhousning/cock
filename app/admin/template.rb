ActiveAdmin.register Template  do

  permit_params  :name, :nest, :image, :index, :new, :edit, :show, :form, :js, :scss, :admin

  menu label: Setting.templates.label
  config.per_page = 20
  config.sort_order = "id_asc"

  
  filter :name, :label => Setting.templates.name
  filter :nest, :label => Setting.templates.nest
  filter :image, :label => Setting.templates.image
  filter :index, :label => Setting.templates.index
  filter :new, :label => Setting.templates.new
  filter :edit, :label => Setting.templates.edit
  filter :show, :label => Setting.templates.show
  filter :form, :label => Setting.templates.form
  filter :js, :label => Setting.templates.js
  filter :scss, :label => Setting.templates.scss
  filter :admin, :label => Setting.templates.admin
  filter :created_at

  index :title=>Setting.templates.label + "管理" do
    selectable_column
    id_column
    
    column Setting.templates.name, :name
    column Setting.templates.nest, :nest
    column Setting.templates.image, :image
    column Setting.templates.index, :index
    column Setting.templates.new, :new
    column Setting.templates.edit, :edit
    column Setting.templates.show, :show
    column Setting.templates.form, :form
    column Setting.templates.js, :js
    column Setting.templates.scss, :scss
    column Setting.templates.admin, :admin

    column "创建时间", :created_at, :sortable=>:created_at do |f|
      f.created_at.strftime('%Y-%m-%d %H:%M:%S')
    end
    column "更新时间", :updated_at do |f|
      f.updated_at.strftime('%Y-%m-%d %H:%M:%S')
    end
    actions
  end

  form do |f|
    f.inputs "添加" + Setting.templates.label do
      
      f.input :name, :label => Setting.templates.name 
      f.input :nest, :label => Setting.templates.nest 
      f.input :image, :label => Setting.templates.image 
      f.input :index, :label => Setting.templates.index 
      f.input :new, :label => Setting.templates.new 
      f.input :edit, :label => Setting.templates.edit 
      f.input :show, :label => Setting.templates.show 
      f.input :form, :label => Setting.templates.form 
      f.input :js, :label => Setting.templates.js 
      f.input :scss, :label => Setting.templates.scss 
      f.input :admin, :label => Setting.templates.admin 
    end
    f.actions
  end

  show :title=>Setting.templates.label + "信息" do
    attributes_table do
      row "ID" do
        template.id
      end
      
      row Setting.templates.name do
        template.name
      end
      row Setting.templates.nest do
        template.nest
      end
      row Setting.templates.image do
        template.image
      end
      row Setting.templates.index do
        template.index
      end
      row Setting.templates.new do
        template.new
      end
      row Setting.templates.edit do
        template.edit
      end
      row Setting.templates.show do
        template.show
      end
      row Setting.templates.form do
        template.form
      end
      row Setting.templates.js do
        template.js
      end
      row Setting.templates.scss do
        template.scss
      end
      row Setting.templates.admin do
        template.admin
      end

      row "创建时间" do
        template.created_at.strftime('%Y-%m-%d %H:%M:%S')
      end
      row "更新时间" do
        template.updated_at.strftime('%Y-%m-%d %H:%M:%S')
      end
    end
  end

end
