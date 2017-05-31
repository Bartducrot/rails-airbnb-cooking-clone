class RecipesController < ApplicationController
  before_action :set_recipe, only: [:show, :destroy, :edit, :update]

  def index
    @recipes = Recipe.all
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.user = current_user
    if @recipe.save
      redirect_to recipe_path(@recipe)
    else
      render :new
    end
  end

  def edit
  end

  def update
    @recipe.update(recipe_params)
    redirect_to recipe_path(@recipe)
  end

  def show
    @transactions = @recipe.transactions
    @transaction = Transaction.new
    @status_current_user = had_buy(@transactions, current_user.id)
    @user = current_user
  end

  def destroy
    @recipe.destroy
    redirect_to recipes_path
  end




  private

  def set_recipe
    @recipe = Recipe.find(params[:id])
  end


  def recipe_params
    params.require(:recipe).permit(:cooking_time, :difficulty, :price, :cuisine_type, :title, :description, :instructions,  :photo, :photo_cache)
  end

  def had_buy(transactions, id)
    lis = []
    transactions.each do |transaction|
      lis << transaction.user_id
    end
    return lis.include? current_user.id
  end

end


