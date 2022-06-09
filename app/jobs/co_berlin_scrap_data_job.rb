class CoBerlinScrapDataJob < ApplicationJob
  queue_as :critical

  def perform
    ::Events::CoBerlinScrapper.scrap
  end
end
