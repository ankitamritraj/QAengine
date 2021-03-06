class SessionsController < ApplicationController
  def new
    @questions = Question.all
    @user_all = User.all
    @questions_all = Question.all
    @user_questions = Question.all
  end

  def create
    @user_all = User.all
    @questions_all = Question.all    
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
       redirect_back_or user
    else
    	flash.now[:danger] = 'Invalid email/password combination' # Not quite right!
      # Create an error message.
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to login_path
  end

end
