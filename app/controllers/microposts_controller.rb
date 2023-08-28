class MicropostsController < ApplicationController
  before_action :logged_in_user
  before_action :correct_user, only: :destroy

  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success] = "Micropost created!"
      redirect_to root_url

    else
      @pagy, @feed_items = pagy current_user.feed.newest, items: 10
      render 'static_pages/home', status: :unprocessable_entity
    end
  end

  def destroy
    if @micropost.destroy
      flash[:success] = "Micropost deleted"
    else
      flash[:danger] = "Micropost can't be deleted"
    end
    redirect_to request.referrer || root_url
  end


  private

  def micropost_params
    params.require(:micropost).permit(:content, :image)
  end

  def correct_user
    @micropost = current_user.microposts.find_by(id: params[:id])
    return if @micropost

    flash[:danger] = "You can't delete this micropost"
    redirect_to request.referrer || root_url
  end
end
