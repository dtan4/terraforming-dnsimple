require "codeclimate-test-reporter"
CodeClimate::TestReporter.start

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'terraforming/dnsimple'

require 'webmock/rspec'
WebMock.disable_net_connect!(:allow => "codeclimate.com")
