class EventsScrapDataJob < ApplicationJob
  queue_as :critical

  def perform
    CoBerlinScrapDataJob.perform_later
    VisitBerlinScrapDataJob.perform_later
  end
end
