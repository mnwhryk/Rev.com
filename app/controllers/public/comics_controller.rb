class Public::ComicsController < ApplicationController

  def index
    @comics = Comic.all
    @user = User.find(params[:id])
  end

  def show
    @comic = Comic.find_by(isbn: params[:isbn])
    @reviews = @comic.reviews
    @tag = Tag.new
    @tags = @comic.tags
    @user = User.find_by(id: params[:id], name: params[:name])
  end

end
