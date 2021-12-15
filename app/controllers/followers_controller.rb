class FollowersController < ApplicationController
  before_action :require_user_logged_in!

  def index; end

  def create
    return unless Current.user

    @user = User.find_by(username: params[:username])
    follow = Follower.where(following_id: @user.id, follower_id: Current.user.id).first_or_initialize
    if follow.id.nil?
      follow.update_attribute(:follower_id, Current.user.id)
      redirect_to "/#{@user.username}", notice: 'You followed'
    else
      follow.destroy
      redirect_to "/#{@user.username}", notice: 'You unfollowed'
    end
  end

  def show_following
    @user = User.find_by(username: params[:username])
    @pagy, @following = pagy(Follower.all.where(follower_id: @user.id))
  end

  def show_followers
    # abort params[:username].inspect
    @user = User.find_by(username: params[:username])
    @pagy, @followers = pagy(Follower.all.where(following_id: @user.id))
  end
end
