class RelationshipsController < ApplicationController
	before_action :logged_in_user

	def create
		@user = User.find(params[:followed_id])
		@questions = current_user.questions
		@following_users = current_user
		current_user.follow(@user)
		respond_to do |format|
	      format.html { redirect_to @user }
	      format.js
	    end
	end

	def destroy
		@user = Relationship.find(params[:id]).followed
		@questions = current_user.questions
		@following_users = current_user
		current_user.unfollow(@user)
		respond_to do |format|
	      format.html { redirect_to @user }
	      format.js
	    end
	end
end
