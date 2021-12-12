class SavesController < ApplicationController
  def index
    @user = User.find_by(username: params[:username])
    return redirect_to "/#{params[:username]}" unless Current.user && @user.id == Current.user.id

    @saves = PostSaved.where(user_id: @user.id).order(created_at: :desc).pluck(:post_id)
    @posts = Post.where(id: [@saves]).order(created_at: :desc)

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
