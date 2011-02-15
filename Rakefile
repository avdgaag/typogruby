require 'bundler'
Bundler::GemHelper.install_tasks
Bundler.setup

task :default => :test

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/test_*.rb'
  test.verbose = true
end

require 'yard'
YARD::Rake::YardocTask.new do |t|
  t.options = [
    '--files', 'LICENSE',
    '--files', 'HISTORY.md',
    '--title', 'Typogruby API documentation'
  ]
end

