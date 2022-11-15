class ReviewsController < ApplicationController

  before_action :find_idea
  before_action :authenticate_user!, except: [:index, :show]
  # before_action :authorize_user!, only: [:destroy]

  def create
    @review = Review.new(review_params)
    @review.idea = @idea
    @review.user = current_user
    if @review.save
      flash[:success] = "Review successfully created"
      redirect_to @idea
    else
      flash[:error] = "Something went wrong"
      render 'ideas/show', status: 303
    end
  end
  

  def destroy
    @review = Review.find(params[:id])
    if can?(:crud, @review)
      @review.destroy
      flash[:success] = 'Review was successfully deleted.'
      redirect_to idea_review_url
    else
      flash[:error] = 'Something went wrong'
      redirect_to idea_path
    end
  end


  private

  def find_idea
    @idea = Idea.find params[:idea_id]
  end

  def review_params
    params.require(:review).permit(:rating, :body)
  end

  def authorize_user!
    redirect_to root_path, alert: "Not authorized!" unless can?(:crud, @comment)
  end

end
