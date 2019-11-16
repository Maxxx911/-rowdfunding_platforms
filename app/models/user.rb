require 'bcrypt'

class User < ApplicationRecord
  include BCrypt

  validates :first_name, :middle_name, :last_name,
            :birthday, :encrypted_password, presence: true
  validates :email, :login, uniqueness: true, presence: true
  has_and_belongs_to_many :projects
  has_many :payments
  has_many :comments

  def password
    @encrypted_password ||= Password.new(encrypted_password)
  end

  def password=(new_password)
    @encrypted_password = Password.create(new_password)
    self.encrypted_password = @encrypted_password
  end
end
