require File.dirname(__FILE__) + '/helper'

require 'errornot_notifier/rails'

class RailsInitializerTest < Test::Unit::TestCase
  include DefinesConstants

  should "trigger use of Rails' logger if logger isn't set and Rails' logger exists" do
    rails = Module.new do
      def self.logger
        "RAILS LOGGER"
      end
    end
    define_constant("Rails", rails)
    ErrornotNotifier::Rails.initialize
    assert_equal "RAILS LOGGER", ErrornotNotifier.logger
  end

  should "trigger use of Rails' default logger if logger isn't set and Rails.logger doesn't exist" do
    define_constant("RAILS_DEFAULT_LOGGER", "RAILS DEFAULT LOGGER")

    ErrornotNotifier::Rails.initialize
    assert_equal "RAILS DEFAULT LOGGER", ErrornotNotifier.logger
  end

  should "allow overriding of the logger if already assigned" do
    define_constant("RAILS_DEFAULT_LOGGER", "RAILS DEFAULT LOGGER")
    ErrornotNotifier::Rails.initialize

    ErrornotNotifier.configure(true) do |config|
      config.logger = "OVERRIDDEN LOGGER"
    end

    assert_equal "OVERRIDDEN LOGGER", ErrornotNotifier.logger
  end
end
