class UsersController < ApplicationController
  before_action :find_user, except: %i(index new create)
  before_action :logged_in_user, only: %i(index edit update destroy)
  before_action :correct_user, only: %i(edit update)
  before_action :admin_user, only: :destroy

  def index
    @pagy, @users = pagy User.all, items: Settings.configs.pagy.item_per_page
  end

  def show
    @user = User.find_by id: params[:id]
    return if @user

    flash[:danger] = t("active_record.users.flash.user_not_found")
    redirect_to root_path
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params # Not the final implementation!
    if @user.save
      # Handle a successful save.
      reset_session
      log_in @user
      flash[:success] = t(".user_created_successfully")
      redirect_to @user
    else
      render "new"
    end
  end

  def edit; end

  def update
    if @user.update user_params
      flash[:success] = t(".user_updated_successfully")
      redirect_to @user
    else
      render :edit
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = t(".user_deleted_successfully")
    else
      flash[:danger] = t(".user_deleted_failed")
    end
    redirect_to users_url
  end

  private

  def user_params
    params.require(:user).permit :name, :email, :password,
                                 :password_confirmation
  end

  def admin_user
    redirect_to root_url unless current_user.admin?
  end

  def find_user
    @user = User.find_by id: params[:id]
    return if @user

    flash[:warning] = t("users.common.user_not_found")
    redirect_to root_path
  end

  def correct_user
    return if current_user? @user

    flash[:danger] = t("users.common.wrong_user")
    redirect_to root_path
  end

  # Confirms a logged-in user.
  def logged_in_user
    return if logged_in?

    store_location
    flash[:danger] = t("users.common.please_log_in")
    redirect_to login_url, status: :see_other
  end
end
