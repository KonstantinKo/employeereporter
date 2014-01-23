module ReportMailerHelper
  def mood_to_smiley mood
    case mood.to_i
    when 1
      ":-)"
    when 2
      ":-|"
    when 3
      ":-("
    else
      "?"
    end
  end

  def average_mood_from reports
    moods = reports.map { |report| report.mood.to_f }
    (moods.reduce(:+).to_f / moods.size.to_f).round
  end
end
