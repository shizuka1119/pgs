class LikesController < ApplicationController

	def create
		@like = Like.new(like_params)
		@like.save
		redirect_to item_path
	end

	def destroy
		@like = Like.find_by(like_params)
		@like.destroy
		redirect_to item_path
	end

  private
  def like_params
      params.require(:like).permit(:user_id, :item_id)
  end
end