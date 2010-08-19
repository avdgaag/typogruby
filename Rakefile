require 'rubygems'
require 'rake'
require 'bundler'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "typogruby"
    gem.summary = %Q{Improves web typography like Django's Typogrify}
    gem.description = %Q{Improve web typography using various text filters. This gem prevents widows and applies markup to ampersans, consecutive capitals and initial quotes.}
    gem.email = "arjan@arjanvandergaag.nl"
    gem.homepage = "http://avdgaag.github.com/typogruby"
    gem.authors = ["Arjan van der Gaag"]
    gem.add_bundler_dependencies
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/test_*.rb'
  test.verbose = true
end

begin
  require 'rcov/rcovtask'
  Rcov::RcovTask.new do |test|
    test.libs << 'test'
    test.pattern = 'test/**/test_*.rb'
    test.verbose = true
  end
rescue LoadError
  task :rcov do
    abort "RCov is not available. In order to run rcov, you must: sudo gem install spicycode-rcov"
  end
end

task :test => :check_dependencies

task :default => :test

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
  task :yardoc do
    abort "YARD is not available. In order to run yardoc, you must: sudo gem install yard"
  end
end
