require "rake/testtask"

Rake::TestTask.new do |t|
  t.libs << "test"
  t.test_files = FileList['test/**/*_test.rb']
  t.verbose = true
end

require "nhk-easy-ruby"
desc "Fetch the latest news list from NHK News Web Easy"
task :fetch do
  news = Net::HTTP.get(NHK::Easy::BASE_URI+"news-list.json")
  File.write("tmp/news-list.json", news)
end
