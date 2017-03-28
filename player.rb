class Player
  attr_reader :cards, :name
  attr_accessor :money

  @@start_money = 100

  def initialize
    @money = @@start_money
    @cards = CardStock.new
  end

  def ask_name
    puts 'Введите ваше имя:'
    @name = gets.chomp
  end

  def use_desk(desk)
    @desk = desk
  end

  def take_card
    @cards.add_random_from(@desk)
  end

  def return_cards
    @cards.move_all_to(@desk)
  end
end
