# == Schema Information
#
# Table name: users
#
#  id             :integer          not null, primary key
#  first_na       :varchar(100)      not null
#  email          :varchar(30)      not null, unique
#  role           :varchar          not null, default 0
#
#
#  index_users_on_email (email)
#

class User < ApplicationRecord
  has_secure_password
  has_many :file_references
  # has_secure_password :recovery_password, validations: false

  # user = User.create(first_name: 'n', email: 'up694452@myport.ac.uk', password: '123', password_confirmation: '123')
  enum roles: [:user, :admin]
end
