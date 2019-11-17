class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :first_name,
             :middle_name, :last_name,
             :login, :birthday
end
