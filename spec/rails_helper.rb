ENV['RAILS_ENV'] ||= 'test'
require 'spec_helper'
require File.expand_path('../../config/environment', __FILE__)
require 'rspec/rails'
require 'devise'
require 'shoulda/matchers'
require 'email_spec'
require 'rspec/autorun'
require "capybara/rspec"
require 'database_cleaner'

Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
  # config.use_transactional_fixtures = true
  DatabaseCleaner.strategy = :truncation
  config.infer_spec_type_from_file_location!
  config.render_views
  config.include FactoryGirl::Syntax::Methods
  config.include EmailSpec::Helpers
  config.include EmailSpec::Matchers
  config.include ActiveSupport::Testing::TimeHelpers
  config.include Devise::Test::ControllerHelpers, type: :controller
  config.include LoginHelper, type: :controller
  config.include IntegrationHelper, type: :feature
end