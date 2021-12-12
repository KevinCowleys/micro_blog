# Current.user.id
class PostsController < ApplicationController
  protect_from_forgery with: :null_session

  def index
    @posts = Post.all.order(created_at: :desc)
    @post = Current.user.posts.new
  end

  def create
    # abort params.inspect
    @post = Current.user.posts.new(post_params)
    if @post.save
      redirect_to root_path, notice: 'Successfully created post'
    else
      redirect_to root_path, alert: @post.errors.messages
    end
  end

  def destroy
    return unless Current.user

    post = Current.user.posts.where(params[:id]).first
    return unless Current.user.id == post.user_id

    if post.destroy
      redirect_back fallback_location: root_path, notice: 'Post Deleted'
    else
      redirect_back fallback_location: root_path, alert: post.errors.messages
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def like
    return unless Current.user

    post_like = Current.user.post_likes.where(like_params).first_or_initialize
    if post_like.id.nil?
      post_like.update(like_params)
      redirect_back fallback_location: root_path, notice: 'Post Liked'
    else
      post_like.destroy
      redirect_back fallback_location: root_path, notice: 'Like Removed'
    end
  end

  def save
    return unless Current.user

    post_save = Current.user.post_saved.where(save_params).first_or_initialize
    if post_save.id.nil?
      post_save.update(save_params)
      redirect_back fallback_location: root_path, notice: 'Post Saved'
    else
      post_save.destroy
      redirect_back fallback_location: root_path, notice: 'Post Unsaved'
    end
  end

  def share
    return unless Current.user

    post_share = Current.user.post_shares.where(share_params).first_or_initialize
    if post_share.id.nil?
      post_share.update(save_params)


      redirect_back fallback_location: root_path, notice: 'Post Shared'
    else
      post_share.destroy
      redirect_back fallback_location: root_path, notice: 'Post Unshared'
    end
  end

  private

  def post_params
    params.require(:post).permit(:content)
  end

  def delete_post
    params.require(:post).permit(:id)
  end

  def like_params
    params.require(:post_like).permit(:post_id)
  end

  def save_params
    params.require(:post_saved).permit(:post_id)
  end

  def share_params
    params.require(:post_share).permit(:id, :comment)
  end
end
