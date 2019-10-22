class GenerateTokenService
  def self.generate(user)
    user.login + user.encrypted_password
  end
end
