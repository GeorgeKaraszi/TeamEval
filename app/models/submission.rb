class Submission < ActiveRecord::Base
  belongs_to :active_class
  belongs_to :group
  belongs_to :user
  belongs_to :assignment
  belongs_to :target_user, class_name: "User", foreign_key: "target_user_id"

  validates :answer1, :answer2, :answer3, :answer4, presence: true
  validates :group_url, :format => URI::regexp(%w(http https))
  validate :distribution_not_exceed_100, :on => [:new, :update]

  public


  #Static method

  def self.number_of_groups_completed(problem_id)
    problem = Assignment.find(problem_id)
    team_list = Group.get_team_list(problem.active_class_id)
    total_competed = 0
    member_needs_to_complete = 0

    team_list.each do |team|
      member_list = Group.get_user_list(problem.active_class_id, team)

      member_list.each do |member|
        if problem.has_to_do_problem(member.id)
          member_needs_to_complete += 1
        end
      end

      if member_needs_to_complete == 0
        total_competed += 1
      end

      member_needs_to_complete = 0

    end

    return total_competed
  end


  def self.get_group_url(team_id, problem_id)
    query = Submission.find_by(team_name_id: team_id, assignment_id: problem_id)

    return query.group_url unless query.nil?

    return 'N/A'
  end

  def self.get_average_answer(user_id, problem_id, answer)
    query_results = Submission.where(assignment_id: problem_id, target_user_id: user_id).pluck(answer)
    total_sum = 0

    query_results.each do |a|
      total_sum += a
    end

    unless total_sum == 0
      return total_sum/query_results.size
    end

    return 0
  end


  def contribute_tally(ass_id, group_id)
    user = get_user_from_group(group_id)

    current_submissions = Submission.where(user_id: user.id, assignment_id: ass_id)
    percent = 0

    current_submissions.each do |s|
      percent += s.answer4
    end
    percent.to_int
  end

  def tally_remainder(ass_id, user_id)
    percent = contribute_tally(ass_id, user_id)
    100 - percent
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

    group_user_id_list.each do |u|
      unless users_evaluated.include?(u)
        needs_to_be_eval << u
      end
    end

    return User.where(id: needs_to_be_eval)

  end

  def distribution_not_exceed_100
      errors.add(:base, 'Group contributions cannot exceed 100%') unless contribute_tally(self.assignment_id, self.user_id) + self.answer4 <= 100
  end

  def get_current_group
    current_group = Group.find_by(user_id: self.user.id)
    current_group unless current_group.nil?
  end

  def get_team_name
    current_team = TeamName.find_by(id: get_current_group.team_name_id)
    current_team unless current_team.nil?
  end

  def get_active_class
    current_class = ActiveClass.find_by(id: get_current_group.active_class_id)
    current_class unless current_class.nil?
  end

  def get_assignment
    current_assignment = Assignment.find_by(active_class_id: get_active_class.id)
    current_assignment unless current_assignment.nil?
  end

  def get_target_user
    current_target_user = User.find_by(id: self.target_user_id)
    current_target_user unless current_target_user.nil?
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

    User.find_by(id: group.user_id)
  end

end