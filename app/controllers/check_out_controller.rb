class CheckOutController < ApplicationController
  def create
    @session =
      Stripe::Checkout::Session.create(
        {
          customer_email: current_user.email,
          success_url: 'https://musifyschool.herokuapp.com/lectures',
          cancel_url: 'https://musifyschool.herokuapp.com/422',
          payment_method_types: ['card'],
          line_items: [{ price: params[:price], quantity: 1 }],
          mode: 'payment'
        }
      )
    puts @session, '-------------------------------------------------------------->'
    respond_to do |format|
      format.js
    end
  end
end
