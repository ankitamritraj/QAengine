class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit,:update]
  before_action :correct_user,   only: [:edit, :update]
  def new
  	@user = User.new
    @questions = Question.all
    @questions_all = Question.all
    @user_all = User.all
  end

  def show
  	@user = User.find(params[:id])
    @users = User.find(params[:id]) 
    @questions = @user.questions
    @user_all = User.all
    @following_users = @user
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

  def edit
    @user=User.find(params[:id])
  end

  def following
    @title = "Following"
    @user = current_user
    # @user  = User.find(params[:id])
    @users = @user.following
    @following_users = @user
    @questions = Question.all
    @user_all = User.all
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user = current_user
    @users = @user.followers
    @following_users = @user
    @questions = Question.all
    @user_all = User.all
    render 'show_follow'
  end

  def search
    #@users=User.search(params)
    @questions = current_user.questions
    @following_users = current_user
    @user_all = User.all
    @users=User.where("name LIKE ?","#{params[:search]}%")
  end

  def term
    
  end

def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
       flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  private
  	def user_params
  		params.require(:user).permit(:name, :email, :city, :state, :institution, :password, :password_confirmation)
  	end
    def logged_in_user
      unless logged_in?
         store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end

      def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
  end
end
