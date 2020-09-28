require 'open-uri'
require 'nokogiri'
require_relative 'Parser.rb'
require_relative 'ParseJazzwillPettel'

# Меню вызывает парсер для разных магазинов по названию сайта
# Сделано для дальнейшего развития, чтобы управлять парсером по одному названию

jazz = Parser.new('Jazzwill')
jazz.print_catalog

pettel = Parser.new('Pettel')
pettel.print_catalog

