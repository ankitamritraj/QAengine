class CommentsController < ApplicationController
	before_action :logged_in_user, only: [:create, :destroy]
	before_action :correct_user, only: :destroy
	def create
		@comment = current_user.comments.build(comment_params)
		@question = @comment.question

		# @comment.question_id = @comment.question.question_id
		

		respond_to do |format|
			if(@comment.save)
				flash[:success] = "Comment Posted Sucssessfully"
				# alert();
				format.html { redirect_to root_url}
				# format.json { render '../static_pages/show', status: :created, location: @question}
				format.js 
				# redirect_to root_url
			else
				format.html { redirect_to root_url}
				# redirect_to root_url
				format.js
			end
				
		end


		# if(@comment.save)
		# 	flash[:success] = "Comment Posted Sucssessfully"
		# 	redirect_to root_url
		# else
		# 	if(@comment.question_id == nil)
		# 	# @feed_items = []
		# 		redirect_to current_user
		# 	else
		# 		redirect_to login_url
		# 	end
		# end
	end

	def destroy
		@question = @comment.question
		@comment.destroy
		respond_to do |format|
				# alert();
				flash[:success] = "Comment deleted Successfully"
				# flash[:success] = "Question Posted Sucssessfully"
				format.html { redirect_to root_url}
				# format.json { render '../static_pages/show', status: :created, location: @question}
				format.js
			end
		# redirect_to root_url
	end

	private
		def comment_params
			params.require(:comment).permit(:content, :question_id, :user_id)
		end

		def correct_user
			@comment = current_user.comments.find_by(id: params[:id])
			redirect_to root_url if @comment.nil?
		end
end
