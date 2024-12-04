class Admin::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_super_admin

  def index
    @users = User.where(role: 'user').page(params[:page]).per(10)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.password = "12345678"
    @user.password_confirmation = "12345678"
    if @user.save
      UserMailer.send_temp_password(@user, "12345678").deliver_now
      redirect_to admin_users_path, notice: 'User created successfully. Temporary password sent via email.'
    else
      flash[:alert] = "Failed to create user: #{@user.errors.full_messages.join(', ')}"
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to admin_users_path, notice: 'User updated successfully.'
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      redirect_to admin_users_path, notice: 'User deleted successfully.'
    else
      redirect_to admin_users_path, alert: 'Failed to delete user.'
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :mobile_number, :email)
  end

  def authorize_super_admin
    # Ensure current_user is a User and is not an array
    if current_user.is_a?(User) && current_user.super_admin?
      return true
    else
      redirect_to root_path, alert: 'Access Denied'  # Redirect if not a super admin
    end
  end
end
  