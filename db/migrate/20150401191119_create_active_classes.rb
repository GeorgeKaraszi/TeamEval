class CreateActiveClasses < ActiveRecord::Migration
  def change
    create_table :active_classes do |t|
      t.string :name
      t.string :number
      t.references :user, index: true

      t.timestamps
    end
  end
end
