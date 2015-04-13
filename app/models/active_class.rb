class ActiveClass < ActiveRecord::Base
  belongs_to :user

  validates :user_id, presence: true
  validate :ensure_user_id_is_instructor
  validates :name, :number, presence: true


  def find_instructor(user_id)
    instructor = User.find_by(:id => user_id)
    instructor.real_name unless instructor.nil?
  end

  def get_instructor
    User.find_by(id: self.user_id).real_name
  end

  def get_all_groups_summery
    Group.where(active_class_id: self.id).to_a.uniq { |g| g.team_name_id }
  end

  def get_all_groups
    Group.order(:team_name_id, :user_id).where(active_class_id: self.id)
  end


  def get_all_users
    User.where(id: get_all_groups.id)
  end

  def get_class_info
    self.name + '(' + self.number + ')'
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

    true
  end
end
