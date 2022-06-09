module Events
  class VisitBerlinScrapper < BaseScrapper
    def scrap
      last_page = false
      page = 0

      until last_page
        page_content = document(page)
        page_content.xpath(CHILD_XPATH).each_slice(BATCH) do |batch|
          batch.each do |event_detail|
            data = {}
            @event_detail = event_detail

            data[:name] = name
            data[:start_date] = start_date
            data[:end_date] = end_date

            klass.find_or_create_by(data)
          end
        end

        last_page = true if page_content.none?
        page += 1
      end
    end

    private

    URL = 'https://www.visitberlin.de/en/event-calendar-berlin'.freeze
    PARENT_XPATH = '//*[@id="main-content"]/div[2]/ul'.freeze
    CHILD_XPATH = 'li'.freeze
    NAME_FIELD_XPATH = './/span[@class="heading-highlight__inner"]'.freeze
    START_DATE_FIELD_XPATH = './/time[1]'.freeze
    END_DATE_FIELD_XPATH = './/time[2]'.freeze
    TIME_FIELD_XPATH = './/span[@class="me__content"][last()]'.freeze
    ITEMS_PER_PAGE = 50

    private_constant :URL, :PARENT_XPATH, :NAME_FIELD_XPATH, :START_DATE_FIELD_XPATH,
                     :END_DATE_FIELD_XPATH, :ITEMS_PER_PAGE

    attr_reader :event_detail

    def document(page)
      Nokogiri::HTML.parse(URI.open("#{URL}?items_per_page=#{ITEMS_PER_PAGE}&page=#{page}")).xpath(PARENT_XPATH)
    end

    def name
      event_detail.xpath(NAME_FIELD_XPATH)[1]&.text&.squish
    end

    def start_date
      rescue_invalid_date do
        "#{event_detail.xpath(START_DATE_FIELD_XPATH)[1]&.text&.squish} #{event_detail.xpath(TIME_FIELD_XPATH)&.text&.squish}".strip.to_datetime
      end
    end

    def end_date
      rescue_invalid_date { event_detail.xpath(END_DATE_FIELD_XPATH)[1]&.text&.to_datetime }
    end
  end
end
