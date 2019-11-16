class Project < ApplicationRecord
  belongs_to :owner, class_name: 'User', foreign_key: :user_id
  has_and_belongs_to_many :users
  has_and_belongs_to_many :categories
  has_many :payments
  has_many :comments
end
