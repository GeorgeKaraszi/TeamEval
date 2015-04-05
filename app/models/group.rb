class Group < ActiveRecord::Base
  belongs_to :user
  belongs_to :team_name
  belongs_to :active_class

  validates :user_id, :team_name_id, :active_class_id, presence: true
  validate :team_exists, :user_exists, :class_exists, :on => [:create, :update]
  validate :is_user_an_instructor
  validates_uniqueness_of :user_id, :scope => :active_class_id,
                          message: 'already belongs to a group in this class'


  def get_user_information
    user = User.find_by(id: self.user_id)
    user.real_name + '(' + user.username + ')'
  end

  def get_team_name
    TeamName.find_by(id: self.team_name_id).name
  end

  def get_active_class
    currentClass = ActiveClass.find_by(id: self.active_class_id)
    currentClass.name + '(' + currentClass.get_instructor + ')' unless currentClass.nil?
  end

  private

  def is_user_an_instructor
    errors.add(:base, 'An instructor cannot be part of a group') unless User.find_by(id: self.user_id, id_type: 2).nil?
  end

  def team_exists
    errors.add(:base, 'Team does not exist!') unless TeamName.find_by(id: self.team_name_id)
  end

  2

  def user_exists
    errors.add(:base, 'User does not exist!') unless User.find_by(id: self.user_id)
  end

  def class_exists
    errors.add(:base, 'Class does not exist!') unless ActiveClass.find_by(id: self.active_class_id)
  end


end
