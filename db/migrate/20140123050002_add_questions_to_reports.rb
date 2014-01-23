class AddQuestionsToReports < ActiveRecord::Migration
  def change
    add_column :reports, :question1, :string
    add_column :reports, :question2, :string
    add_column :reports, :question3, :string
    add_column :reports, :question4, :string
  end
end
