require "rubygems"
require "test/unit"
require "active_support"
require "active_support/test_case"

gem "thoughtbot-shoulda", :version => "2.10.0"
require "shoulda"
require "shoulda/rails"
require "mocha"

begin
  require "redgreen"
rescue
end

require "blueprint"
