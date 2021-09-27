class CheckOutController < ApplicationController
  
  def create
    @session = Stripe::Checkout::Session.create({
      customer: current_user.stripe_customer_id,
      success_url: 'https://musifyschool.herokuapp.com/lectures',
      cancel_url:  'https://musifyschool.herokuapp.com/lectures',
      payment_method_types: ['card'],
      line_items: [
        {price: params[:price] , quantity: 1},
    ],
      mode: 'payment',
    })
    respond_to do |format|
      format.js
    end
  end

end
