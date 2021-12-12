class ProfileController < ApplicationController
  def index
    @user = User.find_by(username: params[:username])
    return unless @user

    @posts = Post.where(user_id: @user.id).order(created_at: :desc)
    @is_viewable = true
    return unless Current.user

    @post_likes = Current.user.post_likes.new
    @post_saved = Current.user.post_saved.new
    return unless @user.id != Current.user.id

    @is_following = Follower.where(
      'follower_id = ? AND following_id = ?', Current.user.id, @user.id
    ).present?
    @is_followed_by = Follower.where(
      'follower_id = ? AND following_id = ?', @user.id, Current.user.id
    ).present?
    @is_blocked = Block.where(
      'blocked_id = ? AND blocked_by_id = ?', @user.id, Current.user.id
    ).present?
    @is_viewable = !Block.where(
      'blocked_id = ? AND blocked_by_id = ?', Current.user.id, @user.id
    ).present?
    @is_muted = Mute.where(
      'muted_id = ? AND muted_by_id = ?', @user.id, Current.user.id
    ).present?
  end

  def settings
    if Current.user
      @user = helpers.current_user
    else
      redirect_to log_in_path, status: 301
    end
  end

  def update_settings
    if Current.user.update(user_params)
      redirect_to settings_path, notice: 'Settings Updated'
    else
      redirect_to settings_path, notice: 'Issues'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :username, :bio, :location, :website, :email, :profile_image, :profile_banner)
  end
end
