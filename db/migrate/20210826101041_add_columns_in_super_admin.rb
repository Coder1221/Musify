class AddColumnsInSuperAdmin < ActiveRecord::Migration[6.1]
  def change
    add_column("super_admins", "name", :string, :limit =>25 , :null => false)
    add_column("super_admins", "schoolname", :string, :limit =>25 ,:null => false)
  end
end