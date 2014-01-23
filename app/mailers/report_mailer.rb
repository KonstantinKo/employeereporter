class ReportMailer < ActionMailer::Base
  default from: "info@arkavis.com"

  def summary_report reports
    @reports = reports
    mail to: 'admin@arkavis.com', subject: 'Summary Report'
  end

  def employee_reminder user
    mail to: user.email, subject: 'Please send in your report!'
  end
end
