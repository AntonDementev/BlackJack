class Cards
  attr_reader :cards

  @@fulldesk = []
  Card.values.each_with_index do |*, index_value|
    Card.suits.each_with_index do |*, index_suit|
      @@fulldesk << Card.new(index_value, index_suit)
    end
  end

  def self.puts_fulldesk
    @@fulldesk.each do |card|
      puts card.open
    end
  end

  def initialize
    empty
  end

  def fulldesk
    @cards = []
    @@fulldesk.each { |card| @cards << card }
  end

  def empty
    @cards = []
  end

  def size
    @cards.size
  end

  def add(card)
    @cards << card
  end

  def add_random_from(stock)
    add(stock.take_random_card)
  end

  def move_all_to(stock)
    @cards.each do |card|
      stock.add(card)
    end
    @cards = []
  end

  def all
    cards_str = ''
    @cards.each { |card| cards_str += card.open }
    cards_str
  end

  def sum
    sum = 0
    aces_amount = 0
    @cards.each do |card|
      value = card.value
      if value.is_a? Integer
        sum += value
      elsif value == 'Туз'
        aces_amount += 1
      else
        sum += 10
      end
    end

    while aces_amount > 0
      sum += if sum + 11 > 21
               1
             else
               11
             end
      aces_amount -= 1
    end

    sum
  end

  def have_ace?
    output = false
    @cards.each do |card|
      if card.value == 'Туз'
        output = true
        break
      end
    end
    output
  end

  def all_closed
    output = ''
    @cards.size.times { output += '[***]' }
    output
  end

  def take_random_card
    random_id = rand(@cards.size)
    card = @cards[random_id]
    @cards.delete_at(random_id)
    card
  end
end
