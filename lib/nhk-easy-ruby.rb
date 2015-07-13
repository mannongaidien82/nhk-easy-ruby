require 'json'
require 'net/http'

module NHK
  module Easy
    BASE_URI = URI("http://www3.nhk.or.jp/news/easy/")
    BASE_MOVIE_URI = URI("rtmp://flv.nhk.or.jp/ondemand/flv/news/&movie=")

    class Client
      def news_list
        # Encode ascii -> utf-8 and remove bom
        data = Net::HTTP
          .get(BASE_URI+"news-list.json")
          .force_encoding('UTF-8')
          .gsub("\xEF\xBB\xBF", '')

        json = Parser.new(data).parse!
        news_list = NewsList.new
        json.map do |list|
          list.keys.each do |date|
            list[date].each do |item|
              news_list.entries << News.new(date: date, item: item)
            end
          end
        end

        return news_list
      end
    end

    class NewsList
      attr_accessor :entries

      def initialize
        @entries = []
      end
    end

    class News
      attr_reader :date
      attr_accessor :news_id, :title, :news_publication_time,
        :has_news_web_image, :has_news_web_movie, :has_news_easy_image,
        :has_news_easy_movie, :has_news_easy_voice, :news_web_image_uri,
        :news_web_movie_uri, :news_easy_image_uri, :news_easy_movie_uri,
        :news_easy_voice_uri, :news_web_url

      def initialize(date: Date.today.to_s, item: {})
        @date = date
        parse_item(item)
      end

      def news_web_easy_url
        NHK::Easy::BASE_URI+"#{news_id}/#{news_id}.html"
      end

      def news_web_image_url
        NHK::Easy::BASE_URI+"#{news_id}/#{news_web_image_uri}"
      end

      def news_web_movie_url
        NHK::Easy::BASE_MOVIE_URI+news_web_movie_uri
      end

      def news_easy_image_url
        NHK::Easy::BASE_URI+"#{news_id}/#{news_easy_image_uri}"
      end

      def news_easy_movie_url
        NHK::Easy::BASE_MOVIE_URI+news_easy_movie_uri
      end

      def news_easy_voice_url
        NHK::Easy::BASE_URI+"#{news_id}/#{news_easy_voice_uri}"
      end

      def has_news_web_image?; !!has_news_web_image; end
      def has_news_web_movie?; !!has_news_web_movie; end
      def has_news_easy_image?; !!has_news_easy_image; end
      def has_news_easy_movie?; !!has_news_easy_movie; end
      def has_news_easy_voice?; !!has_news_easy_voice; end

      private
      def parse_item(item)
        item.each do |key, value|
          self.send("#{key}=", value) rescue next
        end
      end
    end

    class Parser
      def initialize data={}
        @data = data
      end

      def parse!
        JSON.parse @data
      end
    end
  end
end
