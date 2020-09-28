# Класс получает название магазина и на его основе выбирает нужный класс для получения данных
# Потом добавляет мин/макс/среднюю цены
# Можно получить непосредственно массив с каталогом методом .catalog
# Можно вывести на печать методом .print_catalog
class Parser
    attr_reader :catalog
    def initialize(shop_name)
        catalog = []
        # Выбор нужного класса для парсинга разных сайтов
        case shop_name
            when 'Jazzwill'
                work_array = ParseJazzwillPettel.new(shop_name)
            when 'Pettel'
                work_array = ParseJazzwillPettel.new(shop_name)
            end        
        min_value = price_sorter(work_array.data, 'min')
        max_value = price_sorter(work_array.data, 'max')
        average_value = price_sorter(work_array.data, 'average')
        catalog << {name: shop_name}
        catalog += work_array.data
        catalog << {name: '                '}
        catalog << {name: min_value[0], price: min_value[1]}
        catalog << {name: max_value[0], price: max_value[1]}
        catalog << {name: 'Средняя цена:', price: average_value}
        catalog << {name: '--------------'}
        @catalog = catalog
    end
    
    # Выделяет мин/макс/среднню цену, выдавая связку товар-цена или просто цену(среднюю)
    def price_sorter(array_catalog, type)
        catalog_hash = {}
        result = []
        sum = 0
        array_catalog.each do |item|
        catalog_hash[item[:name]] = item[:price]
        sum += item[:price]
        end
        sorted = catalog_hash.sort {|a, b| a[1]<=>b[1]}
        case type
            when 'max'
                result[0] = "Самый дорогой: " + sorted.last[0]
                result[1] = sorted.last[1]
                return result
            when 'min'
                result[0] = "Самый дешевый: " + sorted.first[0]
                result[1] = sorted.first[1]
                return result
            when 'average'
                return sum / catalog_hash.length
            end    
    end

    def print_catalog
        @catalog.each do |item|
            puts item[:name] + "\t" + item[:price].to_s
        end 
    end
end