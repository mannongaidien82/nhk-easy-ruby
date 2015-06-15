# NHK::Easy

Ruby client library for [NHK News Web Easy](http://www.nhk.or.jp/news/easy/).

## Installation

Add this line to your application's `Gemfile`:

```ruby
gem 'nhk-easy-ruby'
```

And then execute:

```bash
$ bundle
```

Or install it yourself as:

```bash
$ gem install nhk-easy-ruby
```

## Usage

In order to get the latest news from NHK, we need to connect to their API.
We use the `NHK::Easy::Client` class to make the connection:

```ruby
client = NHK::Easy::Client.new
```

If we want the latest news, we can use the `news_list()` method:

```ruby
client.news_list
```

This will return a `NHK::Easy::NewsList` instance from the NHK API.

**TODO**: In order to get the featured articles from NHK, we should implement a
similar feature for `top_news()`.

As a side note, the `Client` makes all requests with the following base uri:

```ruby
BASE_URI = "http://www3.nhk.or.jp/news/easy/"
```

### NHK::Easy::NewsList

`NewsList` represents the JSON from NHK news feed as Ruby objects.

```ruby
news = client.news_list

news.entries
#=> [#<NHK::Easy::News:0x007ffa6986df60>, #<NHK::Easy::News:0x007ffa6986df60>]
```

The `entries()` method returns a collection of `News` objects.

### NHK::Easy::News

`News` represents a given article from NHK News Web Easy.

```ruby
news.first
#=> #<NHK::Easy::News:0x007ffa6986df60>

news.first.news_id #=> "k10010110081000"
news.first.news_web_movie_uri #=> "1_201506110537_201506110537.mp4"
news.first.news_easy_voice_uri #=> "k10010110081000.mp3"
```

As well, we can get the full url using `news_web_movie_url()` and `news_easy_voice_url()`:

```ruby
news.first.news_web_movie_url
  #=> rtmp://flv.nhk.or.jp/ondemand/flv/news/&movie=k10010111191_201506111945_201506111945.mp4

news.first.news_easy_voice_url
  #=> http://www3.nhk.or.jp/news/easy/k10010111191000/k10010111191000.mp3
```

Please see the `News` class for all available attributes and methods.
