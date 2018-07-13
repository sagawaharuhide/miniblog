class TweetsController < ApplicationController

 before_action :move_to_index, except: :index

  def index
    @tweets = Tweet.order("created_at DESC").page(params[:page]).per(10)
  end

  def new
    @tweet = Tweet.new
  end

  def create
    Tweet.create(text: tweet_params[:text], user_id: current_user.id)
  end

  def destroy
      tweet = Tweet.find(params[:id])
      tweet.destroy if tweet.user_id == current_user.id
    end

  def edit
    @tweet = Tweet.find(params[:id])
  end

  def update
      tweet = Tweet.find(params[:id])
      tweet.update(tweet_params) if tweet.user_id == current_user.id
  end

  private
  def tweet_params
    params.require(:tweet).permit(:text)
  end

  def move_to_index
    redirect_to action: :index unless user_signed_in?
  end
end
