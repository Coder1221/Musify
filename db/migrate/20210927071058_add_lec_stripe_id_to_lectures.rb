class AddLecStripeIdToLectures < ActiveRecord::Migration[6.1]
  def change
    add_column(:lectures, :lec_stripe_id, :string)
    add_column(:lectures, :lec_stripe_price_id, :string)
  end
end
