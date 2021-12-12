class HomeController < ApplicationController
  def index
    if !Current.user
      @posts = Post.all.order(created_at: :desc)
    else
      blocked_ids = Block.all.where(blocked_by_id: Current.user.id).pluck(:blocked_id)
      blocked_by_ids = Block.all.where(blocked_id: Current.user.id).pluck(:blocked_by_id)
      muted_ids = Mute.all.where(muted_by_id: Current.user.id).pluck(:muted_id)
      avoid_posts = (blocked_ids + blocked_by_ids + muted_ids).uniq
      @posts = Post.all.where.not(user_id: avoid_posts).order(created_at: :desc)
    end
    return unless Current.user

    @post_new = Current.user.posts.new
    @post_delete = Post.new
    @post_likes = Current.user.post_likes.new
    @post_saved = Current.user.post_saved.new
    @post_shares = Current.user.post_shares.new
  end
end
