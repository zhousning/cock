class Rails::ItemGenerator < Rails::Generators::Base
  source_root File.expand_path('../templates', __FILE__)
  
  #model或attrs 也可通过@model或@columns访问
  argument :model, :type => :string, :default => "model"
  argument :columns, :type => :array, :default => []

  class_option :name, :aliases => '-n',  :type => :string, :default => ""

  class_option :label, :aliases => '-l', :type => :array, :default => []
  class_option :tag, :aliases => '-t', :type => :array, :default => []

  class_option :image, :aliases => '-i', :type => :boolean, :default => false 

  class_option :index, :aliases => '-x', :type => :boolean, :default => true 
  class_option :new, :aliases => '-w', :type => :boolean, :default => true 
  class_option :edit, :aliases => '-e', :type => :boolean, :default => true 
  class_option :show, :aliases => '-h', :type => :boolean, :default => true 
  class_option :form, :aliases => '-r', :type => :boolean, :default => true 

  class_option :js, :aliases => '-j', :type => :boolean, :default => true 
  class_option :scss, :aliases => '-c', :type => :boolean, :default => true 

  class_option :admin, :aliases => '-a', :type => :boolean, :default => true 

  class_option :fields, :aliases => '-z', :type => :array, :default => []
  class_option :relates, :aliases => '-y', :type => :array, :default => []

  def generate_model
    #attributes = columns.join(" ")
    #generate "model", "#{model} #{attributes} --force"
    #generate "migration", "create_#{model.pluralize} #{attributes}"
    @mu = model.underscore
    @mc = model.camelcase
    @mpc = model.pluralize.camelcase
    @mpu = model.pluralize.underscore
    @enclosure = options[:image]
    @fields = options[:fields]

    @attrs = []
    columns.each do |column|
      @attrs << column.slice(/[^:]+/)
    end

    name = Time.now.strftime('%Y%m%d%H%M%S') + "_create_" + @mpu
    @relates   = options[:relates]
    @columns   = columns
    template 'migration.template', "db/migrate/#{name}.rb", @mpc, @mpu, @relates, @columns
    template 'model.template', "app/models/#{@mu}.rb", @attrs, @mu, @mc, @mpc, @mpu, @enclosure, @fields, @relates
  end

  def generate_setting
    model_name = model.pluralize.underscore
    hash = Hash.new
    hash["label"] = options[:name]
    columns.each_with_index do |column, index|
      key = column.slice(/([^:]+)/)
      hash[key] = options[:label][index]
    end
    Setting.save(model_name, hash)
  end

  def generate_controller_view
    @mu = model.underscore
    @mc = model.camelcase
    @mpc = model.pluralize.camelcase
    @mpu = model.pluralize.underscore
    @enclosure = options[:image]
    @index = options[:index]
    @new  = options[:new]
    @edit = options[:edit]
    @show = options[:show]
    @form = options[:form]
    @js   = options[:js]
    @scss = options[:scss]
    @admin = options[:admin]
    @fields = options[:fields]

    @attrs = []
    columns.each do |column|
      @attrs << column.slice(/[^:]+/)
    end

    template 'controller.template', "app/controllers/#{controller_name}_controller.rb", @attrs, @mu, @mc, @mpc, @mpu, @enclosure, @index, @new, @edit, @show, @fields

    if @index
      template 'index.template', "app/views/#{controller_name}/index.html.haml", @attrs, @mu, @mc, @mpc, @mpu, @enclosure
    end

    if @form
      template '_form.template', "app/views/#{controller_name}/_form.html.haml", @attrs, @mu, @mc, @mpc, @mpu, @enclosure, @fields
    end

    if @new
      template 'new.template', "app/views/#{controller_name}/new.html.haml", @attrs, @mu, @mc, @mpc, @mpu, @enclosure
    end

    if @edit
      template 'edit.template', "app/views/#{controller_name}/edit.html.haml", @attrs, @mu, @mc, @mpc, @mpu, @enclosure
    end

    if @show
      template 'show.template', "app/views/#{controller_name}/show.html.haml", @attrs, @mu, @mc, @mpc, @mpu, @enclosure
    end

    if @js
      template 'js.template', "app/assets/javascripts/#{controller_name}.js", @attrs, @mu, @mc, @mpc, @mpu
    end

    if @scss
      template 'scss.template', "app/assets/stylesheets/#{controller_name}.scss"
    end

    if @admin
      template 'admin.template', "app/admin/#{@mu}.rb", @attrs, @mu, @mc, @mpc, @mpu, @enclosure
    end

    if @enclosure
      template '_enclosure.template', "app/views/#{controller_name}/_enclosure_fields.html.haml"
    end

    @fields.each do |field|
      template '_fields.template', "app/views/#{controller_name}/_#{field}_fields.html.haml"
    end

  end

  private
    def file_name
      model.underscore
    end

    def controller_name
      model.pluralize.underscore
    end

  #model_singularize = model.singularize.underscore
  #class_option :model_singularize, :type => :string, :default => model_singularize
  #class_option :model_pluralize, :type => :string, :default => model_pluralize
  #generate "controller", "#{controller_name}"
end
