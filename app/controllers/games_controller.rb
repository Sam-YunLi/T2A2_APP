class GamesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_game, only: [:show, :edit, :update, :destroy]
  before_action :authorize_user, only: [:edit, :update, :destory]
  before_action :set_form_vars, only: [:new, :edit]

  # show all the games list
  def index
    
    # search bar, search the list
    if params[:search]
      @search_term = params[:search]
      @games = Game.search_by(@search_term)
      
      # redirect to the all games with notice alert.
      redirect_to games_path, notice: "Sorry, nothing match #{params[:search]}" if @games ==[]
    else
      @games = Game.all # set all the games to display
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
    @game.price = @game.price.to_f/100
  end

  # update the game information
  def update
    @game.update(game_params)
    if @game.save
      redirect_to games_path, notice: "Game successfully updated"
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

  def mygame
    @games = []
    @games = Game.where(user_id: params[:id]).to_a
  end

  def purchased
    @orders = [] 
    @orders = Order.where(buyer_id: params[:id]).to_a

  end

  private

  def game_params
    params.require(:game).permit(:name, :price, :category_id, :condition, :description, :platform_id, :display, :picture, feature_ids: [])
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

end
