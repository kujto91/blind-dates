class CreateRestorants < ActiveRecord::Migration[7.1]
  def change
    create_table :restorants do |t|
      t.string :name, null: false
      t.text :descripton
      t.string :phone
      t.string :address_street
      t.string :address_number
      t.string :address_postcode
      t.string :address_town

      t.timestamps
    end
  end
end
