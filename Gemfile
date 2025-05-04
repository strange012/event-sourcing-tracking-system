# frozen_string_literal: true

source 'https://rubygems.org'

ruby '3.4.3'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails', branch: 'main'
gem 'rails', '~> 8.0'

# Use postgresql as the database for Active Record
gem 'pg', '~> 1.5'
gem 'pg_search', '~> 2.3'
gem 'store_model', '~> 4.2'

# Use the Puma web server [https://github.com/puma/puma]
gem 'puma', '>= 5.0'

# Serialization
gem 'blueprinter'
gem 'blueprinter-activerecord'

# Pagination
gem 'kaminari'

# Use Redis adapter to run Action Cable in production
# gem 'redis', '>= 4.0.1'

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem 'kredis'

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem 'bcrypt', '~> 3.1.7'

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[windows jruby]

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', require: false

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem 'image_processing', '~> 1.2'

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin Ajax possible
gem 'rack-cors'

# Use dry-monads for service objects
gem 'dry-initializer', '~> 3.1'
gem 'dry-monads', '~> 1.6'

group :development, :test do
  # Use pry for debugging
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'pry'
  gem 'rspec-rails', '~> 6.1.0'
  gem 'rubocop', require: false
  gem 'rubocop-factory_bot', require: false
  gem 'rubocop-rails', require: false
  gem 'rubocop-rake', require: false
  gem 'rubocop-rspec', require: false
end

group :development do
  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem 'spring'
end

group :test do
  gem 'database_cleaner-active_record'
end
