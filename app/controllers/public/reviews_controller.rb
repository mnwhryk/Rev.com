class Public::ReviewsController < ApplicationController

  def new
    @review = Review.new
    @tag = Tag.new
    @comic = Comic.find(params[:comic_id])
  end

  def create
    @review = Review.new(review_params)
    @review.user_id = current_user.id
    tag_list = params[:review][:tag_name].split(",")
    if @review.save
      @review.tag_save(tag_list)
      redirect_to comic_path(@review.comic.id), notice: "レビューを追加しました"
    else
      @comic = Comic.find(params[:comic_id])
      render :new
    end
  end

  def index
    @tags = review.tags
    @reviews = @comic.reviews
  end

  def show
    @comic = Comic.find(params[:comic_id])
    @review = Review.find(params[:id])
    @comment = Comment.new
  end

  def edit
    @review = Review.find(params[:id])
    @comic = Comic.find(params[:id])
  end

  def update
    @review = Review.find(params[:id])
    if @review.update(review_params)
      redirect_to comic_reviews_path(@review.id), notice: "更新しました"
    else
      render :edit
    end
  end

  def destroy
    @review = Review.find(params[:id])
    @comic = Comic.find(params[:id])
    @review.destroy
    redirec_to comic_path(@comic.id), notice: "レビューを削除しました"
  end

  # def search_comic
  #   @tag_list = Tag.all
  #   @tag = Tag.find(params[:id])
  #   @comics = @tag.review.comics
  # end

  private
  def review_params
    params
      .require(:review)
      .permit(:comic_id, :user_id, :review, 
        :rate, tag_attributes: [:coimc_id, :user_id, :tag_name])
  end
  # def tag_list
  #   params.require(:tag).permit(:comic_id, :user_id, :tag_name)
  # end

end
