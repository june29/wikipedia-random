# -*- coding: utf-8 -*-
require "open-uri"
require "uri"
require "bundler"
Bundler.require

url = "http://ja.wikipedia.org/wiki/%E7%89%B9%E5%88%A5:Random"
document = Nokogiri::HTML(open(url).read)

title = document.css("title").text.sub(/- Wikipedia$/, "")
link  = "http://ja.wikipedia.org/wiki/#{URI.encode(title)}"

puts title

related_words = document.css("#content a").select { |a|
  a.attributes["href"].to_s =~ %r{^/wiki/}
}.map { |a| a.attributes["title"].to_s }.reject { |word|
  word.nil? || word.length == 0
}

print "関連語は？ > "
answer = gets.chomp

puts
puts related_words.include?(answer) ? "おめでとう、正解です！" : "残念、不正解です。"
puts
puts related_words.sort.join(", ")
puts link
