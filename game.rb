#!/usr/bin/env ruby

require_relative 'card'
require_relative 'cards'

@desk = Cards.new
@desk.fulldesk

@player_cards = Cards.new
@ai_cards = Cards.new

@player_money = 100
@ai_money = 100

puts 'Введите ваше имя:'
@player_name = gets.chomp


def show_game_data
  puts "Игрок #{@player_name}:"
  puts "  Деньги: #{@player_money}$"
  puts "  Карты: #{@player_cards.all}"
  puts 'Диллер:'
  puts "  Деньги: #{@ai_money}$"
  puts "  Карты: #{@ai_cards.all_closed}"
  puts "Банк: #{@bank_money}$"
end

#loop do
  @player_money -= 10
  @ai_money -= 10
  @bank_money = 20
  
  
  2.times { @player_cards.take_random_from(@desk) }
  2.times { @ai_cards.take_random_from(@desk) }

  show_game_data



#end
