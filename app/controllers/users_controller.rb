class UsersController < ApplicationController
  def index
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      # session[:user_id] = @user.id
      cookies[:auth_token] = @user.auth_token
      redirect_to root_url, notice: "You have signed up"
    else
      render "new"
    end
  end

end
