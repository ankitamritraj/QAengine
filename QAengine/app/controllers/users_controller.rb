class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update]

  def new
  	@user = User.new
  end

  def show
  	@user = User.find(params[:id])
    @questions = @user.questions
    # @comments = @questions.comments
  end

  def create
  	@user = User.new(user_params)
  	if @user.save
  		log_in @user
      flash[:success] = "Weclome to QAengine"
  		redirect_to user_path(@user)
  	else
  		render 'new'
  	end
  end

  private
  	def user_params
  		params.require(:user).permit(:name, :email, :city, :state, :institution, :password, :password_confirmation)
  	end
end
