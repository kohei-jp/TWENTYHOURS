class UsersController < ApplicationController

  def show
    user = User.find(params[:id])
    @name = user.name
    @tweets = user.tweets.page(params[:page]).per(5).order("created_at DESC")
  end
<<<<<<< Updated upstream
=======

  def show # routingで[:id]が渡ってきている
    @user = User.find(params[:id])
    @tags = @user.tags #これでいいはず(リレーションが上手くいっていれば)
    @name = @user.name
    @tweets = current_user.tweets.joins(:tag).group('tag_name').includes(:user, :tag).sum(:time)
    @mytimes = @user.tweets.group_by_day(:created_at).sum(:time)
    # binding.pry
    # 一旦、.order("created_at DESC").page(params[:page]).per(9)は削除
    # @times = @tweets.sum(:time)

    # @times = Tweet.group('user_id, tag_id').sum(:time)

    tweets = @user.tweets #fav用
    @favorite_tweets = @user.favorite_tweets #fav用
    # favorite_tweetsとは、user.rbで定義した、favしたtweetsテーブルのこと

    # user = User.find(params[:id]) #follow用
    @fallow_users = @user.followings #follow用

    # user = User.find(params[:id]) #follower用
    @follower_users = @user.followers #follower用
  end

  def calc_total
    tweets.joins(:tags)
      .group(Tweets.arel_table[:id]).select('project_users.*, sum(work_time) as sum_work_times, sum(extra_cost) as sum_extra_costs')
  end

# ==============追加================
def follows
  user = User.find(params[:id])
  @users = user.followings
  redirect_to tweet_path
end

def followers
  user = User.find(params[:id])
  @users = user.followers
  redirect_to tweet_path
end
# ==============追加================

>>>>>>> Stashed changes
end
