class Employee < ApplicationRecord
  belongs_to :user
  belongs_to :department
  has_many :bills
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :designation, presence: true
  validates :department_id, presence: true
end
