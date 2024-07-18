class Tenant < ApplicationRecord
  acts_as_tenant(:account_id)  # Define account_id as the tenant column

  enum plan: { free: 0, premium: 1 }

  validates :name, presence: true
  validates :plan, presence: true

  has_many :users, dependent: :destroy
end
