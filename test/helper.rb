require 'rubygems'
require 'bundler'
require 'test/unit'

Bundler.setup

$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'typogruby'

class Test::Unit::TestCase
  include Typogruby
end
