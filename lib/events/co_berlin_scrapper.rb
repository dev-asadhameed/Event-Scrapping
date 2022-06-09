module Events
  class CoBerlinScrapper < BaseScrapper
    def scrap
      document.xpath(CHILD_XPATH).each_slice(BATCH) do |batch|
        batch.each do |event_detail|
          data = {}
          @event_detail = event_detail

          data[:name] = name
          data[:start_date] = start_date
          data[:end_date] = end_date

          klass.find_or_create_by(data)
        end
      end
    end

    private

    URL = 'https://co-berlin.org/en/program/calendar'.freeze
    PARENT_XPATH = '//div[@class="views-row"]'.freeze
    CHILD_XPATH = './/div[@class="node__content"]'.freeze
    FIRST_NAME_FIELD_XPATH = './/div//h2'.freeze
    LAST_NAME_FIELD_XPATH = './/div[last()-1]'.freeze
    START_DATE_FIELD_XPATH = './/span[@class="date-display-range"]'.freeze
    END_DATE_FIELD_XPATH = './/span[@class="date-display-range"]'.freeze

    private_constant :URL, :PARENT_XPATH, :FIRST_NAME_FIELD_XPATH, :LAST_NAME_FIELD_XPATH,
                     :START_DATE_FIELD_XPATH, :END_DATE_FIELD_XPATH

    attr_reader :event_detail

    def document
      @document ||= Nokogiri::HTML.parse(URI.open(URL)).xpath(PARENT_XPATH)
    end

    def name
      "#{event_detail.xpath(FIRST_NAME_FIELD_XPATH)&.text&.squish} #{event_detail.xpath(LAST_NAME_FIELD_XPATH)&.last&.text&.squish}".strip
    end

    def start_date
      rescue_invalid_date do
        event_detail.xpath(START_DATE_FIELD_XPATH)&.text&.split('–')&.first&.to_datetime
      end
    end

    def end_date
      rescue_invalid_date { event_detail.xpath(END_DATE_FIELD_XPATH)&.text&.split('–')&.last&.to_datetime }
    end
  end
end
