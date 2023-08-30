class UsersController < ApplicationController
  before_action :logged_in_user, except: %i(show new create)
  before_action :find_user, except: %i(index new create)
  before_action :correct_user, only: %i(edit update)
  before_action :admin_user, only: :destroy

  def index
    @pagy, @users = pagy User.all, items: Settings.configs.pagy.user_per_page
  end

  def show
    @pagy, @microposts = pagy @user.microposts,
                              items: Settings.configs.pagy.micropost_per_page
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      @user.send_activation_email
      flash[:info] = t(".check_your_email")
      redirect_to root_url
    else
      render :new
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
    return if current_user.admin?

    flash[:danger] = t("users.common.not_admin")
    redirect_to root_path
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
end
