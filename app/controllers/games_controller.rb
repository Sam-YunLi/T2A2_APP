class GamesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  before_action :initialize_session
  before_action :load_cart


  before_action :set_game, only: [:show, :edit, :update, :destroy]
  
  before_action :authorize_user, only: [:edit, :update, :destory]
  before_action :set_form_vars, only: [:new, :edit]




  # show all the games list
  def index
    @games = Game.all # set all the games to display

    if params[:search]
      @search_term = params[:search]
      @games = @games.search_by(@search_term)
      if @games=[]
        redirect_to games_path, notice: "Sorry, nothing match #{params[:search]}."
      end
    end




  end

  # show the details of the game
  def show

  end

  # create new game
  def new
    @game = Game.new
  end

  # 
  def create
    @game = current_user.games.new(game_params)
    if @game.save
      redirect_to @game, notice: "Game successfully created"
    else
      set_form_vars
      render "new", notice: "Something went wrong"
    end
  end

  def edit

  end

  # update the game information
  def update
    @game.update.(game_params)
    if @game.save
      redirect_to "games", notice: "Game successfully updated"
    else
      set_form_vars
      render "edit", notice: "Something went wrong"
    end
  end

  # delete the game form the game list
  def destroy
    @game.destroy
    redirect_to games_path, notice: "Game been succesfully deleted."
  end

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

  private

  def game_params
    params.require(:game).permit(:name, :price, :category_id, :condition, :description, :stock, :platform_id, :display, :picture, feature_ids: [])
  end

  def authorize_user
    if @game.user_id != current_user.id
      flash[:alert] = "You have no authorization for that."
      redirect_to games_path
    end
  end

  def set_game
    @game = Game.find(params[:id])
  end

  def set_form_vars
    @categories = Category.all
    @platforms = Platform.all
    @conditions = Game.conditions.keys
    @features = Feature.all
  end

  def initialize_session
    session[:cart] ||= [] # initialize cart
  end

  def load_cart
    @cart = Game.find(session[:cart])
    @cart_ids = session[:cart].map{|a|a.to_i}
  end
end
