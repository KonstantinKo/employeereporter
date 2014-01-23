class Report < ActiveRecord::Base
  belongs_to :user, inverse_of: :reports

  scope :latest, order('created_at DESC').limit(1)

  validates :question1, length: { minimum: 5 }, presence: true
  validates :question2, length: { minimum: 5 }, presence: true
  validates :question3, length: { minimum: 5 }, presence: true
  validates :question4, length: { minimum: 5 }, presence: true

  after_save :check_for_summary_email

  def self.send_summary_email
    user_ids = User.select(:id).all.map { |user| user.id }
    reports = []
    user_ids.each do |user_id|
      reports << Report.latest.where( user_id: user_id ).first
    end

    ReportMailer.summary_report(reports).deliver
  end

  private
    def check_for_summary_email
      users_without_report = User.includes(:reports).all.select { |user| user.reports.empty? }
      if users_without_report.count <= 0
        Report.send_summary_email
      end
    end
end
