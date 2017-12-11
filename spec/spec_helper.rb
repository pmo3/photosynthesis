require 'rack/test'
require 'rspec'

ENV['RACK_ENV'] = 'test'

require File.expand_path '../../app.rb', __FILE__

require 'shoulda-matchers'
require 'faker'
require 'factory_bot'
require 'capybara/rspec'

module RSpecMixin
  include Rack::Test::Methods
  include FactoryBot::Syntax::Methods
  include Warden::Test::Helpers
  def app() described_class end
end

RSpec.configure do |config|
  config.include RSpecMixin

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.filter_run :focus
  config.run_all_when_everything_filtered = true

  config.disable_monkey_patching!

  config.warnings = true

  config.formatter = :documentation
  config.color = true

  config.profile_examples = 10

  config.order = :random

  Kernel.srand config.seed

  config.before(:suite) do
    FactoryBot.definition_file_paths = %w{./factories ./spec/factories}
    FactoryBot.find_definitions
  end

  #shoulda matchers
  config.include(Shoulda::Matchers::ActiveModel, type: :model)
  config.include(Shoulda::Matchers::ActiveRecord, type: :model)

  config.after(:suite) do
    Warden.test_reset!
  end

  config.include Capybara::DSL
  config.include Capybara::RSpecMatchers
  Capybara.app = Photosynthesis::App
end
