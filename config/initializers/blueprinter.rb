# frozen_string_literal: true

Blueprinter.configure do |config|
  config.extensions << BlueprinterActiveRecord::Preloader.new
  config.datetime_format = ->(datetime) { datetime.nil? ? datetime : datetime.strftime('%Y-%m-%d %H:%M:%S.%6N %z') }
end
