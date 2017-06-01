class TransactionsController < ApplicationController

  before_action :set_transaction, except: [:new]
  def new
    @transaction = Transaction.new
  end

  def create
    @transaction = Transaction.new
    @transaction.user = current_user
    @transaction.recipe = @recipe
    if @transaction.save
      redirect_to recipe_path(@recipe)
    else
      render "recipes/show"
    end
  end

  def edit
  end

  def update
    @recipe.update(recipe_params)
    redirect_to recipe_path(@recipe)
  end

  private

  def set_transaction
    @recipe = Recipe.find(params[:recipe_id])
  end

  def transaction_params
    params.require(:transaction).permit(:recipe_id, :rating, :comment)
  end

end
