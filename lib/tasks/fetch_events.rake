# frozen_string_literal: true

desc 'Fetch events based in Berlin'
task fetch_events: :environment do
  EventsScrapDataJob.new.perform
end
