class CreateSubmissions < ActiveRecord::Migration
  def change
    create_table :submissions do |t|
      t.references :active_class, index: true
      t.references :group, index: true
      t.references :user, index: true
      t.references :problem, index: true
      t.string :answer
      t.boolean :complete, default: false

      t.timestamps
    end
  end
end
