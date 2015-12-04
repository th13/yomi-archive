class UsersController < ApplicationController
  include SessionsHelper
  def show
    @user = User.find(current_user)
  end

  def new
    @user = User.new(user_params)
    if @user.save
      log_in(@user)
      puts 'its working'
      redirect_to '/'
    else
      puts 'not working'
      redirect_to '/'
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password,
                                 :password_confirmation)
  end
end
