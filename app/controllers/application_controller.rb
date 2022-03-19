class ApplicationController < ActionController::Base
  before_action :initialize_session
  before_action :load_cart

  # for the cart
  def add_to_cart
    id = params[:id].to_i
    session[:cart] << id unless session[:cart].include?(id)
    redirect_to games_path
  end

  def remove_form_cart
    id = params[:id].to_i
    session[:cart].delete(id)
    redirect_to games_path
  end

  def clear_cart
    session[:cart] = []
    @cart = []
    @cart_ids = []
    
    redirect_to games_path
  end

  private

  def initialize_session
    session[:cart] ||= [] # initialize cart
  end

  def load_cart
    @cart = Game.find(session[:cart])
    @cart_ids = session[:cart].map{|a|a.to_i}
  end
end
