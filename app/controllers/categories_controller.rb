class CategoriesController < ApplicationController
  before_action :find_params, only: [:show, :edit, :update, :destroy]
  def index
    @categories = Category.all.order("created_at DESC")
  end

  def show
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to category_path(@category)
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @category.update(category_params)
      redirect_to category_path(@category)
    else
      render 'edit'
    end
  end

  private
  def category_params
    params.require(:category).permit(:name)
  end
  def find_params
    @category = Category.find(params[:id])
  end
end
