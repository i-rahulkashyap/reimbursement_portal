class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:show, :edit, :update, :destroy, :change_password]
  before_action :authorize_admin, only: [:edit, :update, :destroy]
  def index
    @users = User.order(:id)
  end
  
  def edit
  end


  def show
    @user =  User.find(params[:id])
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_path
  end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: 'User was successfully updated.'
    else
      render :edit
    end
  end

  def change_password
    if @user.update(password_params)
      redirect_to @user, notice: 'Password was successfully updated.'
    else
      render :edit
    end
  end

  def add_to_employee 
    @user = User.find(params[:id])
    @employee = Employee.new(user_id: @user.id, email: @user.email) 
    redirect_to new_employee_path(user_id: @user.id) 
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :role)
  end


  def password_params
    params.require(:user).permit(:password, :password_confirmation)
  end

  def authorize_admin
    redirect_to(root_path, alert: 'You are not authorized to perform this action.') unless current_user.admin?
  end

end
