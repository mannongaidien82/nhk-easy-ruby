require 'helper'

class ParserTest < Minitest::Test
  def test_it_can_parse
    parser = NHK::Easy::Parser.new(FIXTURE_DATA)
    result = parser.parse!
    assert result.first.is_a?(Hash)
  end
end
