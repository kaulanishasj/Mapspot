class AlterColumnTypeLocations < ActiveRecord::Migration
  def up
  	change_column :locations, :user_id	, :string
  end

  def down
  end
end
