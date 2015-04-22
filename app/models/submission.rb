class Submission < ActiveRecord::Base
  belongs_to :active_class
  belongs_to :group
  belongs_to :user
  belongs_to :assignment

  validates :answer1, presence: true
  #validate :form_is_completely_filled, :on => [:create, :update]

  public


  def contribute_tally(ass_id, group_id)
    user = get_user_from_group(group_id)

    current_submissions = Submission.where(user_id: user.id, assignment_id: ass_id)
    percent = 0

    current_submissions.each do |s|
      percent += s.answer5
    end


    return percent

  end

  def users_that_need_eval(ass_id, group_id)
    target_group = Group.find_by(group_id.to_i)

    users_evaluated = Submission.where(user_id: target_group.user_id,
                                       assignment_id: ass_id).pluck(:target_user_id)

    group_user_id_list = Group.where(active_class_id: target_group.active_class_id,
                                     team_name_id: target_group.team_name_id).pluck(:user_id)

    if users_evaluated.size <= 0
      return User.where(id: group_user_id_list)
    end

    needs_to_be_eval = []

    users_evaluated.each do |u|
      unless group_user_id_list.include?(u)
        needs_to_be_eval << u
      end
    end

    return User.where(id: needs_to_be_eval)


  end

  def get_active_class
    currentClass = ActiveClass.find_by(id: self.active_class_id)
    currentClass.name + '(' + currentClass.get_instructor + ')' unless currentClass.nil?
  end

  def get_group_information
    currentGroup = Group.find_by(id: self.group_id)
    currentGroup.id unless currentGroup.nil?
  end

  def get_user_information
    user = User.find_by(id: self.user_id)
    user.real_name unless user.nil?
  end

  def get_assignment_information
    assignment = Assignment.find_by(id: self.assignment_id)
    assignment.name unless assignment.nil?
  end


  private

  def get_user_from_group(group_id)
    group = Group.find_by(group_id)

    User.find_by(group.user_id)
  end

  def group_exists
    errors.add(:base, 'Group does not exist!') unless Group.find_by(id: self.group_id)
  end

  def user_exists
    errors.add(:base, 'User does not exist!') unless User.find_by(id: self.user_id)
  end

  def class_exists
    errors.add(:base, 'Class does not exist!') unless ActiveClass.find_by(id: self.active_class_id)
  end

  def assignment_exists
    errors.add(:base, 'Assignment does not exist!') unless Assignment.find_by(id: self.assignment_id)
  end

  def user_is_in_group
    currentGroup = Group.find_by(id: self.group_id)
    currentUser = User.find_by(id: self.user_id)
    if (currentGroup == nil || currentUser == nil)
      group_exists
      user_exists
    else
      errors.add(:base, 'User is not in this group!') unless currentGroup.user_id == currentUser.id
    end
  end

  def group_is_in_class
    currentGroup = Group.find_by(id: self.group_id)
    currentClass = ActiveClass.find_by(id: self.active_class_id)
    if currentGroup.nil? || currentClass.nil?
      group_exists
      class_exists
    else
      errors.add(:base, 'Group is not in this class!') unless currentClass.id == currentGroup.active_class_id
    end
  end

  def form_is_completely_filled
    if self.answer.nil? || self.answer == ''
      self.complete = false
    else
      self.complete = true
    end
  end

end
