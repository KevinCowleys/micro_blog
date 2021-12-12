class RegistrationsController < ApplicationController
  # instantiates new user
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.username = find_unique(@user.name)
    if @user.save
      # stores saved user id in a session
      session[:user_id] = @user.id
      redirect_to root_path, notice: 'Successfully created account'
    else
      abort @user.errors.inspect
      render :new, alert: @user.errors.messages
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :birth_date, :password, :password_confirmation)
  end

  def find_unique(username)
    test_username = username
  
    while (User.where(username: test_username).any?)
      test_username = "#{username}#{SecureRandom.rand(10000..99999)}"
    end
  
    test_username
  end  
end
