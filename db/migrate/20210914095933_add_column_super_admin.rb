class AddColumnSuperAdmin < ActiveRecord::Migration[6.1]
  def change
    add_column(:super_admins ,:status,  :integer , :default => 1)
  end
end
