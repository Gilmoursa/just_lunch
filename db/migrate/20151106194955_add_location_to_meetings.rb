class AddLocationToMeetings < ActiveRecord::Migration
  def change
    add_column :meetings, :location, :string
  end
end
