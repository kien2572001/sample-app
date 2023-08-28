class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by(email: params[:session][:email].downcase)

    if user.try(:authenticate, params.dig(:session, :password))
      handle_successful_login(user)
    else
      handle_failed_login
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end

  private

  def handle_successful_login user
    forwarding_url = session[:forwarding_url]
    reset_session
    remember_or_forget(user)
    log_in user
    redirect_to forwarding_url || user
  end

  def remember_or_forget user
    if params.dig(:session, :remember_me) == "1"
      remember(user)
    else
      forget(user)
    end
  end

  def handle_failed_login
    flash[:danger] = t(".invalid_email_password_combination")
    render :new, status: :unprocessable_entity
  end
end
