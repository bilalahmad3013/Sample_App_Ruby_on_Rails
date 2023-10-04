class UsersController < ApplicationController
  include SessionsHelper
  before_action :logged_in_user, only: [:index, :edit, :update]
  before_action :correct_user, only: [:edit, :update]
  def new
    @user = User.new
  end

  def index
    @users = User.paginate(page: params[:page])
  end

  def show
    @user = User.find(params[:id])   
   
  end

  def create
    @user = User.new(user_params)       
      @user.email=@user.email.downcase     
    if User.find_by(email: @user.email)
      flash[:alert] = "Email already exists!"
       return

    else
      if @user.save
         
         flash[:success] = "Welcome to the Sample App!"
         redirect_to user_url(@user)               
      end 
    end
    
  end

  def edit
    @user = User.find(params[:id])
  end


  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
    render 'edit'
    end
  end

  def logged_in_user
    unless logged_in?
    store_location
    flash[:danger] = "Please log in."
    redirect_to login_url
    end
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end


    private
    def user_params
    params.require(:user).permit(:name, :email, :password,
    :password_confirmation)
    end
end