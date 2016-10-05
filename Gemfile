source 'https://rubygems.org'

ruby '2.1.5'

gem 'devise'

gem 'rails', '4.2.6'
gem 'rake', '10.5.0'
gem 'puma', '2.11.3'
gem 'secure_headers', '2.2.2'
gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder'
gem 'sass-rails'
gem 'coffee-rails'
gem 'uglifier'
gem 'normalize-rails'
gem 'bootstrap-sass', '~> 3.2.0'
gem 'autoprefixer-rails'
gem 'kaminari'

# Chose which database you wish to use
gem 'sqlite3'

gem 'jquery-turbolinks'
gem 'exception_notification', '4.1.3'

# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :production, :homologacao do
  gem 'rails_12factor', '0.0.3'
  gem 'rack-canonical-host', '0.1.0'
  gem 'rollbar', '2.1.1'
  gem 'librato-rails', '0.11.1'
  gem 'newrelic_rpm', '3.12.0.288'
  gem 'SyslogLogger', '1.4.1'
end

group :development do
  gem 'better_errors', '2.1.1'
  gem 'binding_of_caller', '0.7.2'
  # Para envios de email (testes em dev)
  gem 'letter_opener',        '1.4.1'
  gem 'bullet', '4.14.7'
  gem 'quiet_assets', '1.1.0'
end

group :test do
  gem 'shoulda-matchers', '2.8.0', require: false
  gem 'shoulda-callback-matchers', '~> 1.1.1'
  gem 'simplecov', '0.10.0', require: false
  # Para testes de email
  gem 'email_spec', '1.6.0'
  gem 'capybara', '2.4.4'
  # Para testes js
  # gem 'poltergeist',          '1.6.0'
  gem 'vcr', '2.9.3'
  gem 'webmock', '1.21.0'
  gem 'database_cleaner', '1.4.1'
end

group :development, :test do
  gem 'rspec-rails', '3.3.3'
  gem 'factory_girl_rails', '4.5.0'
  gem 'pry-rails', '0.3.4'
  gem 'dotenv-rails', '1.0.2'
  gem 'awesome_print', '1.6.1'
  gem 'spring-commands-rspec', '1.0.4'
  gem 'byebug'
  gem 'web-console', '2.2.1'
  gem 'spring', '1.3.6'
end
