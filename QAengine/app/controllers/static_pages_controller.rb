class StaticPagesController < ApplicationController
  def horizontalScroll
   
  end
  def home
  	if logged_in?
  		# @all_question = Question.all
  		@user = User.all
      @user_all = User.all
  		# debugger
      @users = User.find(current_user.id)
  		# @comm = @user.questions
  		@question = current_user.questions.build
  		@comment = current_user.comments.build
  		@feed_items = Question.all
  		@questions = Question.all
      @following_users = @users
      @user_questions = Question.all
    else
      @questions_all = Question.all    
      @user_all = User.all
    end
  end

  def contact
      @questions = Question.all
      @following_users = current_user
      @user_all = User.all
      @questions_all = Question.all
      @user_questions = Question.all
  end
  def tagcloud
       @following_users = current_user
        @user_questions = current_user.questions
  end

  def help
  end

  def term
    @users = current_user
    @questions = Question.all
    @following_users = current_user
    @user_all = User.all
    @questions_all = Question.all
    @user_questions = Question.all
  end 

end
