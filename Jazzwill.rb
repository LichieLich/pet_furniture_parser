require 'open-uri'
require 'nokogiri'

url = 'https://jazzwill.ru/collection/all'
html = open(url)
doc = Nokogiri::HTML(html)

catalog = []
doc.xpath("//div[contains(@class,'product_preview product_preview--product_list')]").each do |item|
    name = item.at_css('a')['title']
    #price = /\d+\s*\d*/.match( item.css('.prices-current').text.strip)
    price = /\d+\s*\d*/.match(item.css("span[class^='price']").text.strip)
    catalog.push(
      name: name,
      price: price
    )
end

catalog.each do |item|
    puts item[:name] + "\t\t" + item[:price].to_s + 'руб'
end



