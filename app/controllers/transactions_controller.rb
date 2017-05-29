class TransactionsController < ApplicationController
  def new
    @transaction = Transaction.new
  end

  def create
    @transaction = Transaction.new(transaction_params)
    @transaction.user = current_user
    if @transaction.save
      redirect_to self
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

  private

  def set_transaction
    @recipe = Recipe.find(params[:id])
  end

  def transaction_params
    params.require(:transaction).permit(:recipe_id, :rating, :comment)
  end

end
