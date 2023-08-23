class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params.dig(:sessions, :email)&.downcase)
    if user && user.authenticate( params.dig(:sessions, :password) )
      log_in user
      redirect_to user
    else
      flash.now[:danger] = t("sessions.create.invalid_email_password_combination")
      render :new
    end
  end

  def destroy
  end
end
