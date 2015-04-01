class ActiveClass < ActiveRecord::Base
  belongs_to :user

  public
  def get_instructor
    User.where(:id_type => 2).collect{ |u| [u.real_name, u.id]}
  end
end
