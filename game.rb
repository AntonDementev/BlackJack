#!/usr/bin/env ruby

require_relative 'card'
require_relative 'cards'
CARD_MAX = 3
BET = 10

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
  puts "  Карты: #{@player_cards.all} (#{@player_cards.sum})"
  puts 'Диллер:'
  puts "  Деньги: #{@ai_money}$"
  puts "  Карты: #{@ai_cards.all_closed}"
  puts "Банк игры: #{@bank_money}$"
end

def show_command_list
  puts
  puts 'Введите номер действия:'
  puts '1. Взять карту' if @player_cards.size < CARD_MAX
  puts '2. Пропустить ход'
  puts '3. Открыть карты '
end

def opencards
  player_sum = @player_cards.sum
  ai_sum = @ai_cards.sum
  tie = false
  if player_sum > 21 && ai_sum > 21
    tie = true
  elsif player_sum > 21
    player_win = false
  elsif ai_sum > 21
    player_win = true
  elsif ai_sum > player_sum
    player_win = false
  elsif player_sum > ai_sum
    player_win = true
  elsif player_sum == ai_sum
    tie = true
  end

  puts
  if tie
    puts 'Ничья'
    puts "#{@bank_money}$ переходят в следующий раунд"
  elsif player_win
    puts "Игрок #{@player_name} победил"
    @player_money += @bank_money
    @bank_money = 0
  else
    puts 'Диллер победил'
    @ai_money += @bank_money
    @bank_money = 0
  end

  puts "Карты игрока: #{@player_cards.all}, очки: #{player_sum}"
  puts "Карты диллера: #{@ai_cards.all}, очки: #{ai_sum}"
  puts "Игрок: #{@player_money}$; Диллер: #{@ai_money}$"

  @player_cards.move_all_to(@desk)
  @ai_cards.move_all_to(@desk)
end

def ai_step
  ai_sum = @ai_cards.sum
  ace = @player_cards.have_ace?
  
  if ai_sum == 21 || ai_sum == 20
    ai_take_card(false)
    return
  end
  
  if ace
    case ai_sum
    when 19
      ai_take_card_with_rand(5)
    when 18
      ai_take_card_with_rand(15)
    when 17
      ai_take_card_with_rand(45)
    when 16
      ai_take_card_with_rand(90)
    else
      ai_take_card(true) 
    end
  else
    case ai_sum
    when 19
      ai_take_card(false)
    when 18
      ai_take_card_with_rand(5)
    when 17
      ai_take_card_with_rand(10)
    when 16
      ai_take_card_with_rand(25)
    when 15
      ai_take_card_with_rand(40)
    when 14
      ai_take_card_with_rand(60)
    when 13
      ai_take_card_with_rand(85)
    when 12
      ai_take_card_with_rand(95)
    else
      ai_take_card(true) 
    end
  end
  
end

def ai_take_card_with_rand(probability)
  #@fixrand нужно обновлять в начале игры и после того как игрок берёт карту
  #эта переменная нужна, чтобы игрок не мог увеличивать вероятность взятия карты, пропуская ходы
  if @fixrand < probability
    ai_take_card(true)
  else
    ai_take_card(false)
  end
end

def update_fixrand
  @fixrand = rand(100)
end

def ai_take_card(do_take_card)
  puts
  if do_take_card
    @ai_cards.add_random_from(@desk)
    puts 'Диллер взял карту'
  else
    puts 'Диллер пропустил ход'
  end
end

def check_to_opencards
  if (@player_cards.size == CARD_MAX && @ai_cards.size == CARD_MAX) || @player_cards.sum > 21 || @ai_cards.sum > 21
    true
  else
    false
  end
end

loop do
  @player_money -= BET
  @ai_money -= BET
  @bank_money += BET * 2

  2.times { @player_cards.add_random_from(@desk) }
  2.times { @ai_cards.add_random_from(@desk) }
  
  update_fixrand
  
  loop do
    show_game_data
    show_command_list
    cmd = gets.to_i
    case cmd
    when 1
      if @player_cards.size < CARD_MAX
        @player_cards.add_random_from(@desk)
        show_game_data
        update_fixrand
      end
    when 3
      opencards
      break
    end

    if check_to_opencards
      opencards
      break
    end

    ai_step if @ai_cards.size < CARD_MAX

    if check_to_opencards
      opencards
      break
    end
  end

  puts 'Хотите продолжить? 1. Да 2. Нет'
  cmd2 = gets.to_i
  break if cmd2 == 2
end
