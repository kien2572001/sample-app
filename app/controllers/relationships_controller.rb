class RelationshipsController < ApplicationController
  before_action :logged_in_user
  before_action :load_user, only: :create
  before_action :load_relationship, only: :destroy

  def create
    @user = User.find_by id: params[:followed_id]
    return unless @user

    current_user.follow(@user)
    respond_to do |format|
      format.html{redirect_to @user}
      format.turbo_stream
    end
  end

  def destroy
    @user = Relationship.find(params[:id]).followed
    return unless @user
    current_user.unfollow(@user)
    respond_to do |format|
      format.html{redirect_to @user, status: :see_other}
      format.turbo_stream
    end
  end

  private

  def load_user
    @user = User.find_by id: params[:followed_id]
    return if @user

    flash[:danger] = t("relationships.common.user_not_found")
    redirect_to root_path
  end

  def load_relationship
    @user = Relationship.find_by(id: params[:id]).followed
    return if @user

    flash[:danger] = t("relationships.common.relationship_not_found")
    redirect_to root_path
  end
end
