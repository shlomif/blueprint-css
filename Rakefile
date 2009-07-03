require "rake"
require "rake/testtask"
require "rake/rdoctask"

desc "Test Blueprint"
Rake::TestTask.new(:test) do |t|
  t.libs << "lib"
  t.libs << "test"
  t.pattern = "test/**/*_test.rb"
  t.verbose = true
end

