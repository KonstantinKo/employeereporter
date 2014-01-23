class Report < ActiveRecord::Base
  belongs_to :user, inverse_of: :reports

  validates :question1, length: { minimum: 5 }, presence: true
  validates :question2, length: { minimum: 5 }, presence: true
  validates :question3, length: { minimum: 5 }, presence: true
  validates :question4, length: { minimum: 5 }, presence: true
end
