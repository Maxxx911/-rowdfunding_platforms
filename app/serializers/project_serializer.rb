class ProjectSerializer < ActiveModel::Serializer
  attributes :id, :title, :description,
             :end_time, :sum_goal,
             :current_sum, :image_url
  belongs_to :owner,
             class_name: 'User',
             source: :user
  has_many :users
  has_many :categories
  has_many :comments
  has_many :payments
end
