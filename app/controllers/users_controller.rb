class UsersController < ApplicationController
  include SessionsHelper
  def show
    @user = User.find(current_user)
  end

  def update
    @user = User.find(params[:id])

    if @user.update_attribute(:max_unknown, params[:maxUnknown])

      redirect_to '/read'
    else
      @error = "Something happened"
      #redirect_to '/read'
    end
  end

  def new
    @user = User.new(user_params)
    if @user.save
      log_in(@user)
      redirect_to '/'
    else
      redirect_to root_url
    end
  end

  def login
    user = User.find_by(email: params[:email].downcase)
    if user && user.authenticate(params[:password])
      log_in user
      redirect_to root_url
    else
      flash.now[:danger] = 'Invalid email/password combination'
      redirect_to root_url
    end
  end

  def logout
    log_out
    redirect_to '/'
  end

  private

  def user_params
    params.require(:user).permit(:email, :password,
                                 :password_confirmation)
  end
end
