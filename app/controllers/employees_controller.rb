class EmployeesController < ApplicationController
  before_action :authenticate_user!
  # before_action :authorize_admin!
  before_action :authorize_employee, only: [:index, :show, :new, :create, :edit, :update, :destroy]
  
  def index
    @employees = Employee.all
  end

  def show
    @employee = Employee.find(params[:id])
  end

  def new
    if params[:user_id]
      user = User.find(params[:user_id])
      @employee = Employee.new(user_id: user.id, email: user.email)
    else
      @employee = Employee.new
    end
  end

  def create
    @employee = Employee.new(employee_params)
    @employee.user = current_user

    if @employee.save
      redirect_to employees_path, notice: 'Employee was successfully created.'
    else
      redirect_to users_path, alert: @employee.errors.full_messages.join(', ')
    end
  end

  def edit
    @employee = Employee.find(params[:id])
  end

  def update
    @employee = Employee.find(params[:id])
    if @employee.update(employee_params)
      redirect_to employees_path, notice: 'Employee was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @employee = Employee.find(params[:id])
    @employee.destroy
    redirect_to employees_path, notice: 'Employee was successfully deleted.'
  end

  private

  def employee_params
    params.require(:employee).permit(:first_name, :last_name, :email, :designation, :department_id)
  end

  def authorize_admin!
    redirect_to root_path, alert: 'Access denied!' unless current_user.admin?
  end

  def authorize_employee
    authorize Employee
  end
end
