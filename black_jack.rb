class BlackJack
  BET = 10
  CARD_MAX = 3

  def initialize
    @player = PlayerHuman.new
    @ai = PlayerAI.new
    @bank_money = 0
    @desk = CardStock.new
    @desk.fulldesk
    @player.use_desk(@desk)
    @ai.use_desk(@desk)
  end

  def begin_game
    @player.ask_name

    loop do
      begin_round
      puts 'Хотите продолжить? 1. Да 2. Нет'
      cmd2 = gets.to_i
      break if cmd2 == 2
    end
  end

  def begin_round
    @player.money -= BET
    @ai.money -= BET
    @bank_money += BET * 2

    2.times { @player.take_card }
    2.times { @ai.take_card }

    @ai.update_fixrand

    loop do
      show_game_data
      show_command_list
      cmd = gets.to_i
      case cmd
      when 1
        if @player.cards.size < CARD_MAX
          @player.take_card
          show_game_data
          @ai.update_fixrand
        end
      when 3
        opencards
        break
      end

      if check_to_opencards
        opencards
        break
      end

      next unless @ai.cards.size < CARD_MAX
      @ai.step
      if check_to_opencards
        opencards
        break
      end
    end
  end

  def check_to_opencards
    (@player.cards.size == CARD_MAX && @ai.cards.size == CARD_MAX) || @player.cards.sum > 21 || @ai.cards.sum > 21
  end

  def opencards
    player_sum = @player.cards.sum
    ai_sum = @ai.cards.sum
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
      puts "Игрок #{@player.name} победил"
      @player.money += @bank_money
      @bank_money = 0
    else
      puts 'Диллер победил'
      @ai.money += @bank_money
      @bank_money = 0
    end

    puts "Карты игрока: #{@player.cards.all}, очки: #{player_sum}"
    puts "Карты диллера: #{@ai.cards.all}, очки: #{ai_sum}"
    puts "Игрок: #{@player.money}$; Диллер: #{@ai.money}$"

    @player.return_cards
    @ai.return_cards
  end

  def show_game_data
    puts
    puts "Игрок #{@player.name}:"
    puts "  Деньги: #{@player.money}$"
    puts "  Карты: #{@player.cards.all} (#{@player.cards.sum})"
    puts 'Диллер:'
    puts "  Деньги: #{@ai.money}$"
    puts "  Карты: #{@ai.cards.all_closed}"
    puts "Банк игры: #{@bank_money}$"
  end

  def show_command_list
    puts
    puts 'Введите номер действия:'
    puts '1. Взять карту' if @player.cards.size < CARD_MAX
    puts '2. Пропустить ход'
    puts '3. Открыть карты '
  end
end
