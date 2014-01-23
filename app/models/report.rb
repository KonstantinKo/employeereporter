class Report < ActiveRecord::Base
  belongs_to :user, inverse_of: :reports

  scope :latest, order('created_at DESC').limit(1)

  validates :question1, presence: true
  validates :question2, presence: true
  validates :question3, presence: true
  validates :question4, presence: true

  before_save :serialize_multi_inputs
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
    def serialize_multi_inputs
      4.times do |i|
        n = i+1
        send "question#{n}=", jsonify(send("question#{n}"))
      end
    end

    def check_for_summary_email
      users_without_report = User.includes(:reports).all.select { |user| user.reports.empty? }
      if users_without_report.count <= 0
        Report.send_summary_email
      end
    end

    def jsonify array
      sanitized_array = array.select { |element| !element.empty? }
      sanitized_array.to_json
    end
end
