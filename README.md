# Event Scrapping
This is a simple rails application. It basically scraps web application and insert in our DB system. We've scheduled a background job to run after every 15 mins to pull fresh data. Right now we've added scrapper for followings

1. https://co-berlin.org/en/program/calendar
2. https://www.visitberlin.de/en/event-calendar-berlin

## Acceptance Criteria
- Implement the code required to collect this information and show it on a website. Users should be able to see the events on the website.
- Implement a back-end filtering mechanism. Users should be able to filter the events based on different criteria: 
  a. Web Source 
  b. Dates 
  c. Simple partial text search on the title (no need to implement a complex search here, SQL "like" or similar is enough)
- Make it possible to add new events to your website frequently. Users should be able to access fresh events

## Requirements
- Ruby 3.0.0
- Rails 6.1.4
- Redis
## Database
- Postgres 13.2
## Installation steps
- `bundle install`
- `yarn`
- `rake db:create` `rake db:migrate`
- `bundle exec sidekiq`
- `rails s`
## If I had extra time
- I would have written controller test cases using VCR cassettes.
- Improvements in UI/UX.
## Quick start for local development
To populate data for the first time, start sidekiq server and run this `bundle exec rake fetch_events`
The application will be running at http://localhost:3000/
