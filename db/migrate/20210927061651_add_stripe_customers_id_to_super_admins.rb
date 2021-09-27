class AddStripeCustomersIdToSuperAdmins < ActiveRecord::Migration[6.1]
  def change
    add_column(:super_admins, :stripe_customer_id, :string)
  end
end
