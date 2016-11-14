class QuestionsController < ApplicationController
	before_action :logged_in_user, only: [:create, :destroy]
	before_action :correct_user, only: [:destroy]
	def create
		@question = current_user.questions.build(question_params)
		# if(@question.save)
		# 	flash[:success] = "Question Posted Sucssessfully"
		# 	redirect_to root_url
		# else
		# 	@feed_items = []
		# 	redirect_to root_url
		# end

		respond_to do |format|
			if(@question.save)
				# alert();
				flash[:success] = "Question Posted Sucssessfully"
				format.html { redirect_to root_url}
				# format.json { render '../static_pages/show', status: :created, location: @question}
				format.js 
				# redirect_to root_url
			else
				@feed_items = []
				format.html { redirect_to root_url}
				# redirect_to root_url
				format.js
			end
				
		end
	end

	def destroy
		@question.destroy
		flash[:success] = "Question deleted Successfully"
		redirect_to root_url
	end

	def upvote
		@question = Question.all.find_by(id: params[:id])
		@question.upvote_from current_user
		redirect_to root_url
	end

	def downvote
		@question = Question.all.find_by(id: params[:id])
		@question.downvote_from current_user
		redirect_to root_url
	end

	private
		def question_params
			params.require(:question).permit(:content)
		end

		def correct_user
			@question = current_user.questions.find_by(id: params[:id])
			redirect_to root_url if @question.nil?
		end
end
