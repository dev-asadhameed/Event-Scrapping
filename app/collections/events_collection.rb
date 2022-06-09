# Collection for Events controller
# it will implement filter that will run on collection
class EventsCollection < BaseCollection
  private

  def filter_by_name_date_site
    return if params[:query_str].blank?

    filter do
      date = DateTime.parse(params[:query_str])
      @relation.search_by_name_date_site(date)
    rescue Date::Error
      @relation.search_by_name_site(params[:query_str])
    end
  end
end
