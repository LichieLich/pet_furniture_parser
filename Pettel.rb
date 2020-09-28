require 'open-uri'
require 'nokogiri'

url = 'https://pettel.ru/collection/all?page_size=96'
html = open(url)
doc = Nokogiri::HTML(html)
a = 123
catalog = []
doc.xpath("//div[contains(@class, 'product-card')]").each do |item|
    name = item.at_css('a')['title'].strip
    price = /\d+\s*\d*/.match(item.css("span[class^='price']").text.strip)
    catalog.push(
      name: name,
      price: price
    )
end

catalog.each do |item|
    puts item[:name] + "\t" + item[:price].to_s + 'руб'
end