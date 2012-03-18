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

require 'cucumber'
require 'cucumber/rake/task'
Cucumber::Rake::Task.new(:features) do |t|
  t.cucumber_opts = "features --format pretty"
end

def read_version
  @version = File.read(File.join(File.dirname(__FILE__), 'lib', 'version.rb'))[/^\s*VERSION\s+=\s+'([^']+)'$/, 1]
end

def write_version(v)
  file = File.join(File.dirname(__FILE__), 'lib', 'version.rb')
  contents = File.read(file).gsub(/^\s*VERSION\s+=\s+'([^']+)'/) do |m|
    m.sub($1, v)
  end
  File.open(file, 'w') do |f|
    f.write contents
  end
end

desc 'Display the current version number'
task :version do
  puts read_version
end

namespace :version do
  desc 'Explicitly write a new version number'
  task :write do
    write_version ENV['VERSION']
  end

  namespace :bump do
    desc 'Bump version number to new major'
    task :major do
      major, minor, patch = read_version.split('.')
      major = major.to_i + 1
      minor = 0
      patch = 0
      write_version [major, minor, patch].join('.')
    end

    desc 'Bump version number to new minor'
    task :minor do
      major, minor, patch = read_version.split('.')
      minor = minor.to_i + 1
      patch = 0
      write_version [major, minor, patch].join('.')
    end

    desc 'Bump version number to new patch'
    task :patch do
      major, minor, patch = read_version.split('.')
      patch = patch.to_i + 1
      write_version [major, minor, patch].join('.')
    end
  end
end

begin
  require 'yard'
  YARD::Rake::YardocTask.new do |t|
    t.options = [
      '--files', 'LICENSE',
      '--files', 'HISTORY.md',
      '--title', 'Typogruby API documentation'
    ]
  end
rescue LoadError
end
