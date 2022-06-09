class EventsController < ApplicationController
  def index
    @pagy, @events = pagy(collection)
  end

  private

  def collection
    @collection ||= EventsCollection.new(Event.all, search_params).results
  end

  def search_params
    params.permit(:query_str)
  end
end
