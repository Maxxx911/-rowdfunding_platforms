class Payment < ApplicationRecord
  PAYMENT_METHODS = %i[paypal].freeze

  validates :title, :description, :payment_method, presence: true
  belongs_to :project, class_name: 'Project', foreign_key: :project_id
  belongs_to :user, class_name: 'User', foreign_key: :user_id
end
