class AddMoodToReports < ActiveRecord::Migration
  def change
    add_column :reports, :mood, :integer
  end
end
