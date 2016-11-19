class QuestionsController < ApplicationController
	before_action :logged_in_user, only: [:create, :destroy]
	before_action :correct_user, only: [:destroy]
	
	def create
		@question = current_user.questions.build(question_params)
		@questions = Question.all
		@following_users = current_user
		@user_questions = current_user.questions
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
				#flash[:success] = "Question Posted Sucssessfully"
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
	def index
		if logged_in?
			if params[:tag]
				@question=Question.tagged_with(params[:tag])
				@questions = Question.all
				@users = current_user
				@following_users = current_user
				@user_questions = current_user.questions
			else
				@question=Question.all
			end
		else
			redirect_to login_path
		end
	end

	def destroy
		@question.destroy
		@questions = Question.all
		@following_users = current_user
		@user_questions = current_user.questions
		# flash[:success] = "Question deleted Successfully"
		respond_to do |format|
				# alert();
			#	flash[:success] = "Question Deleted Sucssessfully"
				format.html { redirect_to root_url}
				# format.json { render '../static_pages/show', status: :created, location: @question}
				format.js
		end
		# redirect_to root_url
	end

	def upvote
		@question = Question.all.find_by(id: params[:id])
		@question.upvote_from current_user
		respond_to do |format|
			format.html {redirect_to root_url}
			format.js
		end
		# redirect_to root_url
	end

	def downvote
		@question = Question.all.find_by(id: params[:id])
		@question.downvote_from current_user
		respond_to do |format|
			format.html {redirect_to root_url}
			format.js
		end
		# redirect_to root_url
	end

		def qsearch
			if logged_in?
				@questions = Question.all
				@following_users = current_user
		    	@user_questions = current_user.questions
		    	@question=Question.where("content LIKE ?","%#{params[:qsearch]}%")
				if params[:qsearch]
					@questions=Question.tagged_with(params[:qsearch])
	   			end
	   		else
	   			redirect_to login_path
	   		end
  		end

	private
		def question_params
			params.require(:question).permit(:content,:tag_list)
		end

		def correct_user
			@question = current_user.questions.find_by(id: params[:id])
			redirect_to root_url if @question.nil?
		end

		
end
