class Lecture < ApplicationRecord
    belongs_to :super_admin
    has_many :lecture_contents ,dependent: :destroy
    accepts_nested_attributes_for :lecture_contents , reject_if: :all_blank , allow_destroy: true
<<<<<<< HEAD

    after_create do
        # creating a new product of that lecture
        response = Stripe::Product.create(name: self.title)
        # Assigning one dollor to each product
        price_response = Stripe::Price.create({
            unit_amount: 1000,
            currency: "usd",
            product: response.id
        })
        self.update(lec_stripe_id: response.id)
        self.update(lec_stripe_price_id: price_response.id)
    end
=======
>>>>>>> 113b6c1926230cc4341dec8db20107381b6f7983
end
