class User < ApplicationRecord
  has_secure_password
  # has_secure_password :recovery_password, validations: false

  # user = User.create(first_name: 'dasssvid', password: 'empty', password_confirmation: 'empty')
  enum roles: [:user, :admin]
end
