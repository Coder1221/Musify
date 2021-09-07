class CreateSuperAdminSchools < ActiveRecord::Migration[6.1]
  def change
    create_table :super_admin_schools  ,:id => false do |t|
      t.integer :super_admin_id
      t.integer :school_id
    end
    add_index(:super_admin_schools , :super_admin_id)
  end
end