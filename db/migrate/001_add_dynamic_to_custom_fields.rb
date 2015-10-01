class AddDynamicToCustomFields < ActiveRecord::Migration
  def change
    add_column :custom_fields, :dynamic, :boolean, default: false
  end
end
