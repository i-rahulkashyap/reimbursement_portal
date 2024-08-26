class Bill < ApplicationRecord
  belongs_to :user, foreign_key: :submitted_by
  validates :amount, presence: true
  validates :bill_type, presence: true
  validates :status, presence: true

  enum status: { pending: 'pending', approved: 'approved', rejected: 'rejected' }
  enum bill_type: { food: 'food', travel: 'travel', others: 'others' }
end
