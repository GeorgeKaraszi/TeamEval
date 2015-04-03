class ActiveClass < ActiveRecord::Base
  belongs_to :user
  has_many :users

  validates :user_id, presence: true
  validate :ensure_user_id_is_instructor
  validates :name, :number, presence: true


  def find_instructor(user_id)
    instructor = User.find_by(:id => user_id)
    instructor.real_name unless instructor.nil?
  end


  private
  def ensure_user_id_is_instructor
    user = User.find_by(id: self.user_id)

    if user.nil?
      errors.add(:base, 'No user found')
      return false
    end

    if user.id_type != 2
      errors.add(:base, 'User is not instructor type')
      return false
    end

    return true
  end
end
