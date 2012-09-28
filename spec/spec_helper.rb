require "simplecov"
SimpleCov.start do
  add_filter "/spec/"
end

require "bundler"
Bundler.require

Dir[File.join(File.dirname(__FILE__), "support/**/*.rb")].each { |f| require f }