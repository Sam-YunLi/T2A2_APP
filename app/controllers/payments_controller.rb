class PaymentsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:webhook]
  def success
    @game = Game.find(params[:id])

  end

  def webhook
    # security for the webhook request, cos the authenticity tooken is skipped
    begin
      payload = request.raw_post
      header = request.headers['HTTP_STRIPE_SIGNATURE']
      secret = Rails.application.credentials.dig(:stripe, :webhook_signing_secret)
      event = Stripe::Webhook.construct_event(payload, header, secret)
    rescue Stripe::SignatureVerificationError => e
      render jason: {error: "Unauthorised"}, status: 403
      return
    rescue JSON::ParserError => e
      render jason: {error: "Bad request"}, status: 422
      return
    end

    pp "******************"
    pp event
    pp "******************"

    payment_intent_id = event.data.object.payment_intent    
    payment = Stripe::PaymentIntent.retrieve(payment_intent_id)
    game_id = payment.metadata.game_id
    pp payment.charges.data[0].receipt_url
    @game = Game.find(game_id)
    @game.stock -= 1
    @game.save
    # create order and track the information
    
  end

end
