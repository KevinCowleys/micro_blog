class LikesController < ApplicationController
  def index
    @user = User.find_by(username: params[:username])
    @likes = PostLike.where(user_id: @user.id).order(created_at: :desc).pluck(:post_id)
    @posts = Post.where(id: [@likes]).order(created_at: :desc)
    @is_viewable = true
    return unless Current.user && @user.id == Current.user.id

    @post_likes = Current.user.post_likes.new
    @post_saved = Current.user.post_saved.new
    @is_blocked = Block.where(
      'blocked_id = ? AND blocked_by_id = ?', @user.id, Current.user.id
    ).present?
    @is_viewable = !Block.where(
      'blocked_id = ? AND blocked_by_id = ?', Current.user.id, @user.id
    ).present?
  end
end
