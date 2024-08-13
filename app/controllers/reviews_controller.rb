class ReviewsController < ApplicationController

  def create
    @list = List.find(params[:list_id])
    @review = @list.reviews.build(review_params)
    @review.user = current_user
    if @review.save
      redirect_to list_path(@list), notice: "Review successfully added", anchor: "review-form", status: :see_other
    else
      render "lists/show", anchor: "review-form", status: :unprocessable_entity
    end
  end

  def destroy
    @review = Review.find(params[:id])
    @list = @review.list_id
    @review.destroy
    redirect_to list_path(@list), notice: "Review successfully deleted", anchor: "review-form", status: :see_other
  end

  private

  def review_params
    params.require(:review).permit(:comment, :rating)
  end
end
