class Group < ActiveRecord::Base
  belongs_to :user
  belongs_to :team_name
  belongs_to :active_class

  has_many(:users)

  validates :user_id, :team_name_id, :active_class_id, presence: true
  validate :team_exists, :user_exists, :class_exists, on: [:create, :update]
  validate :is_user_an_instructor
  validates_uniqueness_of :user_id, :scope => :active_class_id,
                          message: 'already belongs to a group in this class'

  #Static method
  def self.get_team_list(a_class_id)
    Group.where(active_class_id: a_class_id).uniq.pluck(:team_name_id)
  end

  #Static method
  def self.get_user_list(a_class_id, team_name_id)
    user_id_list = Group.where(active_class_id: a_class_id,
                               team_name_id: team_name_id).pluck(:user_id)

    User.where(id: user_id_list)

  end


  def get_user_information
    user = User.find_by(id: self.user_id)
    user.real_name + '(' + user.username + ')'
  end

  def get_team_name
    TeamName.find_by(id: self.team_name_id).name
  end

  def get_class_information_string
    get_class_room.name + ':' + get_class_room.number + '(' +
        get_class_room.get_instructor + ')' unless get_class_room.nil?
  end

  def get_basic_class_info
    get_class_room.name + '(' + get_class_room.number + ')'
  end

  def get_class_assignments
    Assignment.where(active_class_id: get_class_room.id)
  end

  def get_assignment_id
    current_assignment = Assignment.find_by(active_class_id: self.active_class_id)
    current_assignment.id unless current_assignment.nil?
  end

  def member_count
    Group.where(active_class_id: self.active_class_id,
                team_name_id: self.team_name_id).size
  end

  private

  def get_class_room
    ActiveClass.find_by(id: self.active_class_id)
  end

  def is_user_an_instructor
    errors.add(:base, 'An instructor cannot be part of a group') unless User.find_by(id: self.user_id, id_type: 2).nil?
  end

  def team_exists
    errors.add(:base, 'Team does not exist!') unless TeamName.find_by(id: self.team_name_id)
  end


  def user_exists
    errors.add(:base, 'User does not exist!') unless User.find_by(id: self.user_id)
  end

  def class_exists
    errors.add(:base, 'Class does not exist!') unless ActiveClass.find_by(id: self.active_class_id)
  end


end
