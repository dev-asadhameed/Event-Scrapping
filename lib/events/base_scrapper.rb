module Events
  class BaseScrapper
    require 'open-uri'

    class << self
      def scrap
        new.scrap
      end
    end

    def name; end
    def start_date; end
    def end_date; end
    def document; end

    protected

    URL = ''.freeze
    BATCH = 500

    def klass
      @klass ||= self.class.name.demodulize.gsub('Scrapper', '').safe_constantize
    end

    def rescue_invalid_date
      yield if block_given?
    rescue StandardError
      nil
    end
  end
end
