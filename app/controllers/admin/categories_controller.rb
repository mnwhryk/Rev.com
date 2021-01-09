class Admin::CategoriesController < ApplicationController

  def index
    @category = Category.new
    @categories = Category.all
  end

  def create
    @category = Category.new(category_params)
    @categories = Category.all
    if @category.save
      flash[:notice] = "カテゴリーを追加しました"
      redirect_back(fallback_location: root_path)
    else
      render :index
    end
  end

  def show
    @category = Category.find(params[:id])
  end

  def edit
     @category = Category.find(params[:id])
  end

  def update
     @category = Category.find(params[:id])
     if @category.update(category_params)
       flash[:notice] = "カテゴリーを変更しました"
       redirect_to admin_categories_path
     else
       render :edit
     end
  end

  private
  def category_params
    params.require(:category).permit(:name)
  end

end
