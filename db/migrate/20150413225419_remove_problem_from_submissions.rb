class RemoveProblemFromSubmissions < ActiveRecord::Migration
  def change
    remove_reference :submissions, :problem, index: true
  end
end
