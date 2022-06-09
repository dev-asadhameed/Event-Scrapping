# frozen_string_literal: true

unless Rails.env.test?
  redis_conn = { url: ENV['REDIS_URL'] || 'redis://localhost:6379' }

  Sidekiq.configure_server do |config|
    config.redis = redis_conn

    config.on(:startup) do
      Sidekiq.schedule = YAML.load_file(File.expand_path('../sidekiq_scheduler.yml', __dir__))
      SidekiqScheduler::Scheduler.instance.reload_schedule!
    end
  end

  Sidekiq.configure_client do |config|
    config.redis = redis_conn
  end
end