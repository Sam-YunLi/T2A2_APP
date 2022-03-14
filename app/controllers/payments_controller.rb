class PaymentsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:webhook]
  def success
    @game = Game.find(params[:id])

  end

  def webhook
    payment_intent_id = params[:data][:object][:payment_intent]    
    payment = Stripe::PaymentIntent.retrieve(payment_intent_id)
    game_id = payment.metadata.game_id
    pp payment.charges.data[0].receipt_url
    @game = Game.find(game_id)
    @game.stock -= 1
    @game.save
  end

end
