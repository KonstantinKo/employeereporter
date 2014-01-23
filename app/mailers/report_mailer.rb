class ReportMailer < ActionMailer::Base
  default from: "info@arkavis.com"

  def summary_report reports
    @reports = reports
    mail to: 'admin@arkavis.com', subject: 'Summary Report'
  end
end
