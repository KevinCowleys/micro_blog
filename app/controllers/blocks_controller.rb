class BlocksController < ApplicationController
  before_action :require_user_logged_in!

  def index; end

  def create
    return unless Current.user

    @user = User.find_by(username: params[:username])
    block = Block.where(blocked_id: @user.id, blocked_by_id: Current.user.id).first_or_initialize

    # Need to remove following if blocked
    follower = Follower.where(following_id: @user.id, follower_id: Current.user.id).first_or_initialize
    follower.destroy unless follower.id.nil?
    following = Follower.where(following_id: Current.user.id, follower_id: @user.id).first_or_initialize
    following.destroy unless following.id.nil?

    if block.id.nil?
      block.update_attribute(:blocked_by_id, Current.user.id)
      redirect_to "/#{@user.username}", notice: "You blocked #{@user.username}"
    else
      block.destroy
      redirect_to "/#{@user.username}", notice: "You unblocked #{@user.username}"
    end
  end

  def show_blocked
    @blocks = Block.all.where(blocked_by_id: Current.user.id)
  end
end
