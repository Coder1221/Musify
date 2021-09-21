class AddOmniauthToSuperAdmin < ActiveRecord::Migration[6.1]
  def change
    add_column :super_admins, :provider, :string
    add_column :super_admins, :uid, :string
  end
end
