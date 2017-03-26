#!/usr/bin/env ruby

require_relative 'card'
require_relative 'cards'

desk = Cards.new

40.times { desk.take_random_card }

desk.cards.each { |card| puts card.open}
#Cards.puts_fulldesk

puts "Введите ваше имя:"
player_name = gets.chomp
player_money = 100
ai_money = 100
player_cards = []
ai_cards = []


loop do






end
