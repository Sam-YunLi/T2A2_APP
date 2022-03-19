class PaymentsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:webhook]

  def success
    if params[:id].include? '_'
      @games = Game.find(params[:id].split('_'))
   else
      @games = [Game.find(params[:id])]
   end
    # clean cart after pay
    session[:cart] = []
    @cart = []
    @cart_ids = []
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

    payment_intent_id = event.data.object.payment_intent    
    payment = Stripe::PaymentIntent.retrieve(payment_intent_id)
    game_id = payment.metadata.game_id
    buyer_id = payment.metadata.user_id
    receipt_url = payment.charges.data[0].receipt_url

    if game_id.include? '_'
      @games = Game.find(game_id.split('_'))
    else
      @games = [Game.find(game_id)]
    end

    @games.each do |game|
      game.display = false
      game.save
      
      # create order and track the information
      Order.create(
        game_id: game.id, 
        buyer_id: buyer_id, 
        seller_id: game.user_id, 
        payment_id: payment_intent_id, 
        receipt_url: receipt_url)
    end


  end

  def create_checkout_session
    @char_games = Game.find(params[:id])

    @line_items = []
    @game_ids = ""
    @char_games.each do |game|
      line_item = {
        name: game.name,
        description: game.description,
        amount: game.price,
        currency: 'aud',
        quantity: 1,
      }

      @line_items << line_item

      if @game_ids == ""
        @game_ids = "#{game.id}"
      else
        @game_ids += "_#{game.id}"
      end
    end



    session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      customer_email: current_user && current_user.email,
      line_items: @line_items,
      payment_intent_data: { 
        metadata: { 
          user_id: current_user.id,
          game_id: @game_ids
        }
      },
      success_url: "#{root_url}payments/success/#{@game_ids}",
      cancel_url: root_url
    )
    @session_id = session.id

  end
end
