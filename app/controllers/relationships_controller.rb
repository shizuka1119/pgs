class RelationshipsController < ApplicationController
	before_action :set_current_user

  def create
    user = User.find(params[:follow_id])
    if  following = @current_user.follow(user)
      flash[:notice] = 'Following! Thank you!'
      redirect_to user
    else
      flash.now[:notice] = '!Failure!'
      redirect_to user
    end
  end

  def destroy
    user = User.find(params[:follow_id])
    if following = @current_user.unfollow(user)
      flash[:notice] = 'Following Release'
      redirect_to user
    else
      flash.now[:notice] = '!Failure!'
      redirect_to user
    end
  end
end

