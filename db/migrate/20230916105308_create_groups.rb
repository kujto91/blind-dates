class CreateGroups < ActiveRecord::Migration[7.1]
  def change
    create_table :groups do |t|
      t.belongs_to :restorant, foreign_key: true, null: true
      t.integer :week, null: false

      t.timestamps
    end
  end
end
