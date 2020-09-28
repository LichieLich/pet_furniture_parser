# Ходит на сайт и получает оттуда данные по каталогу товаров в виде массива хэшей Товар:Цена
# Сделано так на случай расширения: если понадобится еще атрибут товара, то он просто добавится в хэш
# И с минимальной доработкой можно будет передавать скольуо угодно атрибутов товара
class ParseJazzwillPettel
    attr_reader :data
    def initialize(shop_name)
        case shop_name
        when 'Jazzwill'
            url = 'https://jazzwill.ru/collection/all'
            path = "//div[contains(@class,'product_preview product_preview--product_list')]"
        when 'Pettel'
            url = 'https://pettel.ru/collection/all?page_size=96'
            path = "//div[contains(@class, 'product-card')]"
        end
    
        html = open(url)
        doc = Nokogiri::HTML(html)
    
        @data = []
        doc.xpath(path).each do |item|
            name = item.at_css('a')['title']
            # Регулярка принимает на вход любое число с разделителем в виде пробела до 999 999 включительно
            price = /\d+\s*\d*/.match(item.css("span[class^='price']").text.gsub(' ', ''))
            @data.push(
              name: name,
              price: price.to_s.to_i
            )
        end
    end
end