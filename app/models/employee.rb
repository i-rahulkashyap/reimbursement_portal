class Employee < ApplicationRecord
  belongs_to :user
  belongs_to :department
  has_many :bills
end
