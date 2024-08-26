class BillsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_bill, only: [:show, :edit, :update, :destroy, :approve, :reject]
  # before_action :authorize_bill, only: [:show, :edit, :update, :destroy, :approve, :reject, :new, :create]
  # after_action :verify_authorized, except: :index
  # after_action :verify_policy_scoped, only: :index
  before_action :authorize_creation, only: [:new, :create]
  

  def index
    # @bills = policy_scope(Bill)
    if current_user.admin?
      @bills = Bill.all
      @total_submitted = @bills.sum(:amount)
      @total_approved = @bills.where(status: 'approved').sum(:amount)
    else
      @bills = current_user.bills
    end
  end

  def show; end

  def new
    @bill = Bill.new
  end

  def create
    @bill = Bill.new(bill_params)
    @bill.submitted_by = current_user.id
    @bill.status = 'pending'
    if @bill.save
      redirect_to bills_path, notice: 'Bill was successfully submitted.'
    else
      render :new
    end
  end

  def edit; end

  def update
    if @bill.update(bill_params)
      redirect_to @bill, notice: 'Bill was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @bill.destroy
    redirect_to bills_url, notice: 'Bill was successfully deleted.'
  end

  def approve
    @bill.update(status: 'approved')
    redirect_to bills_path, notice: 'Bill was successfully approved.'
  end

  def reject
    @bill.update(status: 'rejected')
    redirect_to bills_path, notice: 'Bill was successfully rejected.'
  end

  private

  def set_bill
    @bill = Bill.find(params[:id])
  end

  def authorize_bill
    authorize @bill || Bill
  end

  def authorize_creation
    redirect_to root_path, alert: 'Access denied!' unless current_user.employee? || current_user.admin?
  end

  def bill_params
    params.require(:bill).permit(:amount, :bill_type, :status)
  end
end
