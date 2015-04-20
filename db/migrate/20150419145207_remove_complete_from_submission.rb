class RemoveCompleteFromSubmission < ActiveRecord::Migration
  def change
    remove_column :submissions, :complete, :integer
  end
end
