class CreateSpiders < ActiveRecord::Migration
  def change
    create_table :spiders do |t|
    
      t.string :link,  null: false, default: Setting.systems.default_str
    
      t.string :cookie,  null: false, default: Setting.systems.default_str
    
      t.string :agent,  null: false, default: Setting.systems.default_str
    
      t.string :content_type,  null: false, default: Setting.systems.default_str
    
      t.string :page,  null: false, default: Setting.systems.default_str
    
      t.string :file,  null: false, default: Setting.systems.default_str
    
      t.string :referer,  null: false, default: Setting.systems.default_str
    
      t.string :host,  null: false, default: Setting.systems.default_str
    
      t.string :redirection,  null: false, default: Setting.systems.default_str
    

    

      t.timestamps null: false
    end
  end
end
