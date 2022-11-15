class IdeasController < ApplicationController

  before_action :find_idea, only:[:show, :destroy, :edit, :update]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :authorize_user!, only:[:edit, :update, :destroy]

  def new
    @idea = Idea.new
  end

  def create
    @idea = Idea.new(idea_params)
    @idea.user = current_user
      if @idea.save
        flash[:success] = "Idea successfully saved"
        redirect_to @idea
      else
        flash[:error] = "Something went wrong, make sure you are providing a title and a body to your idea."
        render :new, {alert: "Something went wrong", status: 303}
      end
  end


  def index
    @ideas = Idea.order(created_at: :desc)
    # @likes = @idea.likes.find_by_(user: current_user)
    # if current_user != nil
    # @test_like = @ideas.likes.find_by(user_id: current_user.id)
    #@test_like = Idea.likes.find_by(user_id: current_user.id)
    # end
   # @likes = @ideas.map { |test| test.likes }
  end


  def show
     @reviews = @idea.reviews.order(created_at: :desc)
     @review = Review.new
     @like = @idea.likes.find_by(user: current_user )     
  end

  def destroy
    if @idea
      @idea.destroy
       flash[:notice] = "Idea successfully deleted."
      redirect_to ideas_path
    else
       flash[:error] = "Unable to find a Idea with that ID, try again."
    end
  end



  def edit
  end



  def update
    if @idea.update(idea_params)
      flash[:notice] = "Idea successfully updated."
      redirect_to @idea
    else
      flash[:notice] = "Unable to update Idea.  Try again!"
      render :edit
    end
  end

  def liked
    @ideas = current_user.liked_ideas
  end
  



  private

  def find_idea
    @idea = Idea.find params[:id]
    if @idea

    else
      render "Unable to find this idea."
    end
  end

  def idea_params
    params.require(:idea).permit(:title, :description)
  end

  # def authenticate_user!
  #   redirect_to new_session_path, notice: "Please sign in" unless user_signed_in?
  # end

  def authorize_user!
    redirect_to root_path, alert: "Not authorized!" unless can?(:crud, @idea)
  end

end
