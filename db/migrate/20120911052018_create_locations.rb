class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :name
      t.string :address
      t.float :longitude
      t.float :latitude
      t.boolean :gmaps
      t.references :user

      t.timestamps
    end
    add_index :locations, :user_id
  end
end
