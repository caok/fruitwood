module EventHelper
  def date_merge(event)
    start = event.start_date
    finish = event.end_date
    text = I18n.localize(start, :format => format_year(start))
    binding.pry
    if start == finish
      text
    else
      text + " - #{I18n.localize(finish, :format => format_year(finish))}" unless finish.nil?
    end
  end

  private
  def format_year(time)
    (time.year == Time.zone.now.year) ? :stamp : :stamp_with_year
  end
end
