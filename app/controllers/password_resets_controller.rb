class PasswordResetsController < ApplicationController

  layout 'sessions'

  def new
  end

  def create
    if user = User.find_by_email(params[:email])
      user.send_password_reset
      redirect_to root_url, notice: "Email sent with instructions"
    else
      flash.now.notice = "User not found"
      render :new
    end
  end

  def edit
    @user = User.find_by_password_reset_token!(params[:id])
  end

  def update
    @user = User.find_by_password_reset_token!(params[:id])
    if @user.password_reset_sent_at < 2.hours.ago
      redirect_to new_password_reset_path, alert: "Password reset has expired"
    elsif @user.update_attributes(params[:user]) && @user.password.present?
      cookies[:auth_token] = @user.auth_token
      redirect_to root_url, notice: "Password has been reset"
    else
      render :edit
    end
  end

end
