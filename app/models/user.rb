class User < ActiveRecord::Base
  validates :username, presence: true, uniqueness: true
  validates :real_name, presence: true
  has_secure_password

  def isAdmin
    return false unless self.id_type == 3
    true
  end

  def isInstructor
    return false unless self.id_type == 2
    true
  end

  def isStudent
    return false unless self.id_type == 1
    true
  end
end
