class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable
  has_many :employees
  has_many :bills, foreign_key: :submitted_by

  def admin?
    role == 'admin'
  end

  def employee?
    role == 'employee'
  end
end
