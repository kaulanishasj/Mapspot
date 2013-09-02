class CreateTravelogues < ActiveRecord::Migration
  def change
    create_table :travelogues do |t|
      t.string :address
      t.float :latitude
      t.float :longitude
      t.boolean :gmaps
      t.references :user

      t.timestamps
    end
    add_index :travelogues, :user_id
  end
end
