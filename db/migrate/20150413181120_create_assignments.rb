class CreateAssignments < ActiveRecord::Migration
  def change
    create_table :assignments do |t|
      t.string :name
      t.text :description
      t.references :active_class, index: true
      t.datetime :start_time
      t.datetime :end_time

      t.timestamps
    end
  end
end
