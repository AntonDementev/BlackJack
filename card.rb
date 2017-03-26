class Card
  attr_reader :value
  
  @@suits = %w(♠ ♥ ♣ ♦)
  @@values = (2..10).to_a + %w(Валет Дама Король Туз)
  
  def self.suits
    @@suits
  end
  
  def self.values
    @@values
  end
  
  def initialize(value_id, suit_id)
    @suit = @@suits[suit_id]
    @value = @@values[value_id]
  end
  
  def open
    "[#{@value} #{@suit}]"
  end
end
