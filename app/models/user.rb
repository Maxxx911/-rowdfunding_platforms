require 'bcrypt'

class User < ApplicationRecord
  include BCrypt

  validates :name, :encrypted_password, presence: true
  validates :email, uniqueness: true, presence: true

  def password
    @encrypted_password ||= Password.new(encrypted_password)
  end

  def password=(new_password)
    @encrypted_password = Password.create(new_password)
    self.encrypted_password = @encrypted_password
  end
end
