class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user.try(:authenticate, params.dig(:session, :password))
      # Log the user in and redirect to the user's show page.
      reset_session
      log_in user
      params.dig(:session, :remember_me) == "1" ? remember(user) : forget(user)
      redirect_to user
    else
      # Create an error message.
      flash[:danger] = t "sessions.flash.invalid_email_password_combination"
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end
end
