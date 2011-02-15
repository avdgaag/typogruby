$LOAD_PATH.unshift(File.dirname(__FILE__) + '/../../lib')
Before do
  @aruba_timeout_seconds = 3
end
require 'typogruby'
require 'bundler/setup'
require 'aruba/cucumber'

