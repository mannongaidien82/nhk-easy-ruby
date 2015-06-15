require 'helper'

class ClientTest < Minitest::Test
  def test_it_returns_news_list
    Net::HTTP.stub :get, FIXTURE_DATA do
      client = NHK::Easy::Client.new
      news = client.news_list
      assert news.is_a?(NHK::Easy::NewsList)
      refute_empty news.entries
    end
  end
end
