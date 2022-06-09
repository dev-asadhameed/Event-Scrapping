class VisitBerlinScrapDataJob < ApplicationJob
  queue_as :critical

  def perform
    ::Events::VisitBerlinScrapper.scrap
  end
end
