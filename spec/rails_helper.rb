# This file is copied to spec/ when you run 'rails generate rspec:install'
# require 'simplecov'
# SimpleCov.start 'rails'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../config/environment', __dir__)
# Prevent database truncation if the environment is production
abort('The Rails environment is running in production mode!') if Rails.env.production?
require 'spec_helper'
require 'rspec/rails'
require "action_policy/rspec/dsl"
require 'vcr'
# require "view_component/test_helpers"
# Add additional requires below this line. Rails is not loaded until this point!

# Requires supporting ruby files with custom matchers and macros, etc, in
# spec/support/ and its subdirectories. Files matching `spec/**/*_spec.rb` are
# run as spec files by default. This means that files in spec/support that end
# in _spec.rb will both be required and run as specs, causing the specs to be
# run twice. It is recommended that you do not name files matching this glob to
# end with _spec.rb. You can configure this pattern with the --pattern
# option on the command line or in ~/.rspec, .rspec or `.rspec-local`.
#
# The following line is provided for convenience purposes. It has the downside
# of increasing the boot-up time by auto-requiring all files in the support
# directory. Alternatively, in the individual `*_spec.rb` files, manually
# require only the support files necessary.
#

# Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

# Checks for pending migration and applies them before tests are run.
# If you are not using ActiveRecord, you can remove this line.
ActiveRecord::Migration.maintain_test_schema!
ActiveRecord::Base.logger.level = Logger::INFO
ActionController::Base.logger.level = Logger::ERROR
Rails.logger.level = Logger::ERROR
module ViewSpecHelper
  module ControllerViewHelpers
    def current_user
      raise 'Stub current_user if you want to test the behavior.'
    end

    def user_signed_in?
      raise 'Stub user_signed_in? if you want to test the behavior.'
    end

    def current_admin
      raise 'Stub current_admin if you want to test the behavior.'
    end

    def admin_signed_in?
      raise 'Stub admin_signed_in? if you want to test the behavior.'
    end
  end

  def initialize_view_helpers(view)
    view.extend ControllerViewHelpers
  end
end

RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods
  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true

  config.before do |example|
    # Configure and start Sphinx for request specs
    if example.metadata[:type] == :request
      # ThinkingSphinx::Test.init
      # ThinkingSphinx::Test.start index: false
    end

    # Disable real-time callbacks if Sphinx isn't running
    # ThinkingSphinx::Configuration.instance.settings['real_time_callbacks'] =
    #   (example.metadata[:type] == :request)

    # Configure helper for components testing
    # config.include ViewComponent::TestHelpers, type: :component
    config.include Capybara::RSpecMatchers, type: :component
  end

  config.after do |example|
    # Stop Sphinx and clear out data after request specs
    if example.metadata[:type] == :request
      # ThinkingSphinx::Test.stop
      # ThinkingSphinx::Test.clear
    end
  end
  # RSpec Rails can automatically mix in different behaviours to your tests
  # based on their file location, for example enabling you to call `get` and
  # `post` in specs under `spec/controllers`.
  #
  # You can disable this behaviour by removing the line below, and instead
  # explicitly tag your specs with their type, e.g.:
  #
  #     RSpec.describe UsersController, :type => :controller do
  #       # ...
  #     end
  #
  # The different available types are documented in the features, such as in
  # https://relishapp.com/rspec/rspec-rails/docs
  config.infer_spec_type_from_file_location!

  # Filter lines from Rails gems in backtraces.
  config.filter_rails_from_backtrace!
  # arbitrary gems may also be filtered via:
  # config.filter_gems_from_backtrace("gem name")
  config.include(ViewSpecHelper, type: :view)
  config.before(:each, type: :view) { initialize_view_helpers(view) }

  # configuring vcr
  VCR.configure do |c|
    # directory for VCR cassettes
    c.cassette_library_dir = "spec/vcr"
    # hooking into webmock requests
    c.hook_into :webmock
  end
end