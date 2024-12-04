class UsersController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :authenticate_user!, only: [:index]

  def index
    if user_signed_in? && current_user.role == 'user'
      redirect_to users_dashboard_users_path, alert: "You are already logged in."
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.role = 'user'
    @user.password = SecureRandom.alphanumeric(10) # Generate a secure random password
    @user.pin = rand(1000..9999) # Generate a 4-digit numeric unique PIN
    if @user.save
      redirect_to users_path, notice: 'User created successfully.'
    else
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to users_path, notice: 'User updated successfully.'
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_path, notice: 'User deleted successfully.'
  end

  def users_dashboard 
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :mobile_number, :email)
  end

  def ensure_super_admin
    redirect_to root_path, alert: 'Access denied!' unless current_user.role == 'super_admin'
  end
end
