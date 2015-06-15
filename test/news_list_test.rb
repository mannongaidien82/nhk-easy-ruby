require 'helper'

class NewsListTest < Minitest::Test
  def test_it_returns_news_list
    parsed = NHK::Easy::Parser.new(FIXTURE_DATA).parse!

    Net::HTTP.stub :get, FIXTURE_DATA do
      client = NHK::Easy::Client.new
      news = client.news_list

      expected = parsed.first[parsed.first.keys.first].first
      assert_equal news.entries.first.news_id, expected["news_id"]
    end
  end
end
