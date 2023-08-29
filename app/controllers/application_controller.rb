class ApplicationController < ActionController::Base
  include SessionsHelper
  include Pagy::Backend

  before_action :set_locale
  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options
    {locale: I18n.locale}
  end

  private
  # Confirms a logged-in user.
  def logged_in_user
    return if logged_in?

    store_location
    flash[:danger] = t("users.common.please_log_in")
    redirect_to login_url, status: :see_other
  end
end
