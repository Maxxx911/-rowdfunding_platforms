class User < ApplicationRecord
  validates :name, :email, :encrypted_password, presence: true
  before_save do
    self.encrypted_password = 
  end
end
