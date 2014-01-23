class Report < ActiveRecord::Base
  extend Enumerize

  belongs_to :user, inverse_of: :reports

  scope :latest, order('created_at DESC').limit(1)
  scope :since_last_monday, -> { where("created_at >= ?", Chronic.parse('last Monday')) }

  validates :question1, presence: true
  validates :question2, presence: true
  validates :question3, presence: true
  validates :question4, presence: true
  validates :mood, presence: true

  enumerize :mood, in: [1,2,3]

  before_save :serialize_multi_inputs
  after_save :check_for_summary_email

  def self.send_summary_email
    reports = []
    User.all_ids.each do |user_id|
      reports << Report.latest.where( user_id: user_id ).first
    end

    ReportMailer.summary_report(reports).deliver
  end

  # TODO find scheduler and call this method every friday when reminders need to be sent out
  def self.send_reminders
    User.without_report.each do |user|
      ReportMailer.employee_reminder(user).deliver
    end
  end

  private
    def serialize_multi_inputs
      4.times do |i|
        n = i+1
        send "question#{n}=", jsonify(send("question#{n}"))
      end
    end

    def check_for_summary_email
      Report.send_summary_email if User.without_report.count <= 0
    end

    def jsonify array
      sanitized_array = array.select { |element| !element.empty? }
      sanitized_array.to_json
    end
end
