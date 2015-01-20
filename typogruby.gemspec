# -*- encoding: utf-8 -*-

require './lib/version'

Gem::Specification.new do |s|
  # Metadata
  s.name        = 'typogruby'
  s.version     = Typogruby::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ['Arjan van der Gaag']
  s.email       = %q{arjan@arjanvandergaag.nl}
  s.description = %q{Improve web typography using various text filters. This gem prevents widows and applies markup to ampersans, consecutive capitals and initial quotes.}
  s.homepage    = %q{http://avdgaag.github.com/typogruby}
  s.summary     = %q{Improves web typography like Django's Typogrify}

  # Files
  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # Rdoc
  s.rdoc_options = ['--charset=UTF-8']
  s.extra_rdoc_files = [
     'LICENSE',
     'README.md',
     'HISTORY.md'
  ]

  # Dependencies
  s.add_runtime_dependency 'rubypants'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'aruba'
  s.add_development_dependency 'cucumber'
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'bluecloth'
  s.add_development_dependency 'minitest'
end

