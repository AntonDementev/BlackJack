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
  puts "  Карты: #{@player_cards.all} (#{@player_sum})"
  puts 'Диллер:'
  puts "  Деньги: #{@ai_money}$"
  puts "  Карты: #{@ai_cards.all_closed}"
  puts "Банк игры: #{@bank_money}$"
end

#loop do
  @player_money -= 10
  @ai_money -= 10
  @bank_money = 20
  
  
  2.times { @player_cards.add_random_from(@desk) }
  2.times { @ai_cards.add_random_from(@desk) }
  
  @player_sum = @player_cards.sum

  show_game_data



#end
