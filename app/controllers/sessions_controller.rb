class SessionsController < ApplicationController

  def create
    user = User.find_by_username(params[:user][:username])

    if user.nil?
      flash.now[:errors] = "Invalid username"
      render :new
    else
      if user.is_password?(params[:user][:password])
        login!(user)
        render :new #TODO
      else
        flash.now[:errors] = "Invalid login"
        render :new
      end
    end
  end

  def new
    render :new
  end

  def destroy
    logout!
    redirect_to new_session_url
  end
end
