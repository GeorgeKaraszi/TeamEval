class Assignment < ActiveRecord::Base
  belongs_to :submission

  has_many :submissions
  belongs_to :active_class

  validates :name, :description, :active_class_id, :start_time, :end_time, presence: true
  validate :active_class_exists, :end_not_before_start, :start_time_not_before_current_date, :on => [:create, :update]


  def self.GetQuery(a_id)
    Assignment.find_by(a_id)
  end

  def get_class_name
    ActiveClass.find_by(id: self.active_class_id).name
  end

  def get_class(class_id)

    local_class = ActiveClass.where(id: class_id)

    if local_class.nil?
      return @Class_Current
    end

    @Class_Current = local_class

    return local_class

  end

  def formatted_start_time
    start_time.strftime('%m/%d (%I:%m%p)')
  end

  def formatted_end_time
    end_time.strftime('%m/%d (%I:%m%p)')
  end

  def has_to_do_problem(group_id)
    group = Group.find_by_id(group_id)
    amount = Submission.where(active_class_id: self.active_class_id,
                              team_name_id: group.team_name_id,
                              assignment_id: self.id).size

    if amount < group.member_count
      return true
    end

    false

  end

  def active_class_exists
    errors.add(:base, 'Class does not exist') unless ActiveClass.find_by(id: self.active_class_id)
  end

  def end_not_before_start
    errors.add(:base, 'Invalid start and end times') unless start_time <= end_time
  end

  def start_time_not_before_current_date
    currentTime = Time.zone.now
    errors.add(:base, 'Start date is invalid') unless currentTime <= start_time.end_of_day
  end

end
