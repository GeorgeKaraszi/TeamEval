class AddQuestionsToSubmissions < ActiveRecord::Migration
  def change
    remove_column :submissions, :answer, :string
    add_column :submissions, :answer1, :string
    add_column :submissions, :answer2, :integer
    add_column :submissions, :answer3, :integer
    add_column :submissions, :answer4, :integer
    add_column :submissions, :answer5, :integer
    add_column :submissions, :comment, :string
    add_column :submissions, :target_user_id, :int
  end
end
