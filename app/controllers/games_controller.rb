class GamesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_game, only: [:show, :edit, :update, :destroy]
  before_action :set_form_vars, only: [:new, :edit]

  # show all the games list
  def index
    @games = Game.all
  end

  # show the details of the game
  def show
    @game = Game.find(params[:id])
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
      pp @game.errors
      set_form_vars
      render "new", notice: "Something went wrong"
    end
  end

  # update the game information
  def update
    @game = update.(game_params)
    if @game.save
      redirect_to @game, notice: "Game successfully updated"
    else
      pp @game.errors
      set_form_vars
      render "edit", notice: "Something went wrong"
    end
  end

  # delete the game form the game list
  def destroy
    @game.destory
  end

  private

  def game_params
    params.require(:game).permit(:name, :price, :category_id, :condition, :description, :stock, :platform_id, :display, :picture)
  end

  def set_game

  end

  def set_form_vars
    @categories = Category.all
    @platforms = Platform.all
    @conditions = Game.conditions.keys
  end



end
