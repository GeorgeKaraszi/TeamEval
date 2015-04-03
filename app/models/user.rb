class User < ActiveRecord::Base
  validates :username, presence: true, uniqueness: true
  validates :real_name, presence: true
  has_secure_password
end
