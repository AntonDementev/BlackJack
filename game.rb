#!/usr/bin/env ruby

require_relative 'card'
require_relative 'cards'

@desk = Cards.new
@desk.fulldesk

@player_cards = Cards.new
@ai_cards = Cards.new

@player_money = 100
@ai_money = 100
@bank_money = 0

puts 'Введите ваше имя:'
@player_name = gets.chomp


def show_game_data
  puts
  puts "Игрок #{@player_name}:"
  puts "  Деньги: #{@player_money}$"
  puts "  Карты: #{@player_cards.all} (#{@player_sum})"
  puts 'Диллер:'
  puts "  Деньги: #{@ai_money}$"
  puts "  Карты: #{@ai_cards.all_closed}"
  puts "Банк игры: #{@bank_money}$"
end

def show_command_list
  puts
  puts "Введите номер действия:"
  puts "1. Взять карту"
  puts "2. Пропустить ход"
  puts "3. Открыть карты " 
end

def opencards
  player_sum = @player_cards.sum
  ai_sum = @ai_cards.sum
  @tie = false
  if player_sum > 21 && ai_sum > 21
    @tie = true
  elsif player_sum > 21
    @player_win = false
  elsif ai_sum > 21
    @player_win = true
  elsif ai_sum > player_sum
    @player_win = false
  elsif player_sum > ai_sum
    @player_win = true
  elsif player_sum == ai_sum
    @tie = true
  end
  
  puts
  if @tie
    puts "Ничья"
    puts "#{@bank_money}$ переходят в следующий раунд"
  elsif @player_win
    puts "Игрок #{@player_name} победил"
    @player_money += @bank_money
    @bank_money = 0
  else
    puts "Диллер победил"
    @ai_money += @bank_money
    @bank_money = 0
  end
  
  puts "Карты игрока: #{@player_cards.all}, очки: #{player_sum}"
  puts "Карты диллера: #{@ai_cards.all}, очки: #{ai_sum}"
  puts "Игрок: #{@player_money}$; Диллер: #{@ai_money}$"
  
  @player_cards.empty
  @ai_cards.empty
end

loop do
  @player_money -= 10
  @ai_money -= 10
  @bank_money += 20
  
  
  2.times { @player_cards.add_random_from(@desk) }
  2.times { @ai_cards.add_random_from(@desk) }
  
  loop do
    @player_sum = @player_cards.sum
    show_game_data
    show_command_list
    cmd = gets.to_i
    case cmd
      when 1
        @player_cards.add_random_from(@desk)
        show_game_data
      when 3
        opencards
        break
    end
    
    
  end

  puts "Хотите продолжить? 1. Да 2. Нет"
  cmd2 = gets.to_i
  if cmd2 == 2
    break
  end
end
