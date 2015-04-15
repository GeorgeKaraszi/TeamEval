class AddDetailsToSubmissions < ActiveRecord::Migration
  def change
    add_reference :submissions, :team_name, index: true
  end
end
