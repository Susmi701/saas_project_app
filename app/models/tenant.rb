class Tenant < ApplicationRecord
  enum plan: { free: 0, premium: 1 }


  # validates :name, presence: true
  # validates :plan, presence: true

  has_many :users, dependent: :destroy
end
