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

def read_version
  @version = File.read(File.join(File.dirname(__FILE__), 'lib', 'typogruby.rb'))[/^\s*VERSION\s+=\s+'([^']+)'$/, 1]
end

def write_version(v)
  file = File.join(File.dirname(__FILE__), 'lib', 'typogruby.rb')
  contents = File.read(file).gsub(/^\s*VERSION\s+=\s+'([^']+)'/) do |m|
    m.sub($1, v)
  end
  File.open(file, 'w') do |f|
    f.write contents
  end
end

task :version do
  puts read_version
end

namespace :version do
  task :write do
    write_version ENV['VERSION']
  end

  namespace :bump do
    task :major do
      major, minor, patch = read_version.split('.')
      major = major.to_i + 1
      minor = 0
      patch = 0
      write_version [major, minor, patch].join('.')
    end

    task :minor do
      major, minor, patch = read_version.split('.')
      minor = minor.to_i + 1
      patch = 0
      write_version [major, minor, patch].join('.')
    end

    task :patch do
      major, minor, patch = read_version.split('.')
      patch = patch.to_i + 1
      write_version [major, minor, patch].join('.')
    end
  end
end

require 'yard'
YARD::Rake::YardocTask.new do |t|
  t.options = [
    '--files', 'LICENSE',
    '--files', 'HISTORY.md',
    '--title', 'Typogruby API documentation'
  ]
end

