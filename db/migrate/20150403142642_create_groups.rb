class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.references :user, index: true
      t.references :team_name, index: true
      t.references :active_class, index: true

      t.timestamps
    end
  end
end
