class MutesController < ApplicationController
  before_action :require_user_logged_in!

  def index; end

  def create
    return unless Current.user

    @user = User.find_by(username: params[:username])
    mute = Mute.where(muted_id: @user.id, muted_by_id: Current.user.id).first_or_initialize

    if mute.id.nil?
      mute.update_attribute(:muted_by_id, Current.user.id)
      redirect_to "/#{@user.username}", notice: "You muted #{@user.username}"
    else
      mute.destroy
      redirect_to "/#{@user.username}", notice: "You unmuted #{@user.username}"
    end
  end

  def show_muted
    @pagy, @mutes = pagy(Mute.all.where(muted_by_id: Current.user.id))
  end
end
