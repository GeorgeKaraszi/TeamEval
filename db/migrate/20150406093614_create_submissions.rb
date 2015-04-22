class CreateSubmissions < ActiveRecord::Migration
  def change
    create_table :submissions do |t|
      t.references :active_class, index: true
      t.references :group, index: true
      t.references :team_name, index: true
      t.references :user, index: true
      t.references :assignment, index: true
      t.integer :target_user_id
      t.text :group_url
      t.integer :answer1
      t.integer :answer2
      t.integer :answer3
      t.integer :answer4
      t.text :comment
      t.boolean :complete, default: false

      t.timestamps
    end
  end
end
