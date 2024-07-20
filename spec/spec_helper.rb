require 'rspec'

require 'simplecov'
require 'simplecov-cobertura'

SimpleCov.start do
  add_filter 'spec'
end

SimpleCov.formatters = [
  SimpleCov::Formatter::HTMLFormatter,
  SimpleCov::Formatter::CoberturaFormatter,
]

require 'omniauth-kerberos'

Dir[File.expand_path('spec/support/**/*.rb')].each { |f| require f }

# Disable omniauth logger
class NullLogger < Logger
  def initialize(*_args)
  end

  def add(*_args, &_block)
  end
end

OmniAuth.config.logger = NullLogger.new

RSpec.configure do |config|
  config.order = 'random'
end
