require 'helper'

# Example item:
#   {
#     "news_priority_number"=>"skip",
#     "news_prearranged_time"=>"skip",
#     "news_id"=>"k10010082861000",
#     "title"=>"大阪市の住民投票　「大阪都構想」に反対",
#     "title_with_ruby"=> "skip",
#     "news_file_ver"=>"skip",
#     "news_creation_time"=>"skip",
#     "news_preview_time"=>"skip",
#     "news_publication_time"=>"2015-06-15 11:35:48",
#     "news_publication_status"=>"skip",
#     "has_news_web_image"=>false,
#     "has_news_web_movie"=>false,
#     "has_news_easy_image"=>false,
#     "has_news_easy_movie"=>false,
#     "has_news_easy_voice"=>true,
#     "news_web_image_uri"=>"",
#     "news_web_movie_uri"=>"",
#     "news_easy_image_uri"=>"''",
#     "news_easy_movie_uri"=>"''",
#     "news_easy_voice_uri"=>"k10010082861000.mp3",
#     "news_display_flag"=>"skip",
#     "news_web_url"=> "http://www3.nhk.or.jp/news/html/20150517/k10010082861000.html"
#   }
#
# Values with "skip" can be safely ignored when parsing.
class NewsTest < Minitest::Test
  def test_it_accepts_date_and_hash
    today = Date.today.to_s
    news = NHK::Easy::News.new
    assert news.is_a?(NHK::Easy::News)
    assert_equal news.date, today
  end

  def test_it_sets_attributes
    news = NHK::Easy::News.new(item: {"news_id" => "12345"})
    assert_equal news.news_id, "12345"
  end

  def test_it_provides_url_presenters
    news = NHK::Easy::News.new(item: {
      "news_id" => "zomg",
      "news_web_image_uri" => "foo.jpg",
      "news_web_movie_uri" => "foo.mp4",
      "news_easy_image_uri" => "bar.jpg",
      "news_easy_movie_uri" => "bar.mp4",
      "news_easy_voice_uri" => "bar.mp3"
    })

    assert_equal news.news_web_image_url, NHK::Easy::BASE_URI+"zomg/foo.jpg"
    assert_equal news.news_web_movie_url, NHK::Easy::BASE_MOVIE_URI+"foo.mp4"
    assert_equal news.news_easy_image_url, NHK::Easy::BASE_URI+"zomg/bar.jpg"
    assert_equal news.news_easy_movie_url, NHK::Easy::BASE_MOVIE_URI+"bar.mp4"
    assert_equal news.news_easy_voice_url, NHK::Easy::BASE_URI+"zomg/bar.mp3"
  end

  def test_it_provides_asset_predicates
    news = NHK::Easy::News.new(item: {
      "has_news_web_image"=>false,
      "has_news_web_movie"=>false,
      "has_news_easy_image"=>false,
      "has_news_easy_movie"=>false,
      "has_news_easy_voice"=>true
    })

    refute news.has_news_web_image?
    refute news.has_news_web_movie?
    refute news.has_news_easy_image?
    refute news.has_news_easy_movie?
    assert news.has_news_easy_voice?
  end
end
