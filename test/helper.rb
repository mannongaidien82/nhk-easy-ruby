$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'nhk-easy-ruby'
require 'minitest/autorun'

FIXTURE_PATH = File.expand_path('../../tmp/', __FILE__)
FIXTURE_DATA = File.read(FIXTURE_PATH + "/news-list.json", mode: "r:bom|utf-8")
