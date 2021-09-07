class CreateSchools < ActiveRecord::Migration[6.1]
  def change
    create_table :schools do |t|
      t.integer :super_admin_id
      t.string :name
      t.string :email
      t.string :adress
      t.string :city
      t.string :phone
      t.integer :zip_code
      t.integer :logo ,default: ""
      t.timestamps
    end
    add_index(:schools , :name)
  end
end