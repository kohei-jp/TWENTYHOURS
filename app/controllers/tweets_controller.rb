class TweetsController < ApplicationController
  before_action :set_tweet, only: [:edit, :show]
  before_action :move_to_index, except: [:index, :show, :search]

  def index
    @tweets = Tweet.includes(:user, :tag).order("created_at DESC").page(params[:page]).per(9)
    @times = Tweet.joins(:tag, :user).group('name').group('tag_name').sum(:time)
  end

  def new
    @tweet = Tweet.new
    @tweet.build_tag
  end


  def create
    @tweet = Tweet.new(tweet_params)
    if @tweet.save
      redirect_to tweets_path
    else
      render action: :new
    end
  end

  def edit
  end

  def update
    tweet = Tweet.find(params[:id])
    tweet.update(tweet_params)
  end

  def destroy
    tweet = Tweet.find(params[:id])
    tweet.destroy
  end

  def show
    @comment = Comment.new
    @comments = @tweet.comments.includes(:user)
    @tag = @tweet.tag
  end

  private
  def tweet_params
    params.require(:tweet).permit(:image, :text, :time, tag_attributes: [:tag_name]).merge(user_id: current_user.id)
  end

  def set_tweet
    @tweet = Tweet.find(params[:id])
  end

  def move_to_index
    redirect_to action: :index unless user_signed_in?
  end
end
