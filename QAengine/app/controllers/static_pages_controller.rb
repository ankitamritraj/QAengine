class StaticPagesController < ApplicationController
  def home
  	if logged_in?
  		# @all_question = Question.all
  		@user = User.all
  		# debugger
      @users = User.find(current_user.id)
  		# @comm = @user.questions
  		@question = current_user.questions.build
  		@comment = current_user.comments.build
  		@feed_items = Question.all
  		
  	end
  end

  def contact
  end

  def help
  end

  def term
  end 

end
