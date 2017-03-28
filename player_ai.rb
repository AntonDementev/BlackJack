class PlayerAI < Player
  def initialize
    super
    update_fixrand
  end

  def step
    sum = @cards.sum
    ace = @cards.have_ace?

    if ace
      logic = { above_limit: 19, below_limit: 16, 19 => 5, 18 => 15, 17 => 45, 16 => 90 }
    else
      logic = { above_limit: 18, below_limit: 12, 18 => 3, 17 => 8, 16 => 22, 15 => 40, 14 => 60, 13 => 85, 12 => 95 }
    end

    if sum > logic[:above_limit]
      take_card_message(false)
    elsif sum < logic[:below_limit]
      take_card_message(true)
    else
      take_card_with_rand(logic[sum])
    end
  end

  def take_card_message(take)
    puts
    if take
      take_card
      puts 'Диллер взял карту'
    else
      puts 'Диллер пропустил ход'
    end
  end

  def take_card_with_rand(probability)
    take_card_message(@fixrand < probability)
  end

  # @fixrand нужно обновлять в начале игры и после того как игрок берёт карту
  # эта переменная нужна, чтобы игрок не мог увеличивать вероятность взятия карты, пропуская ходы
  def update_fixrand
    @fixrand = rand(100)
  end
end
