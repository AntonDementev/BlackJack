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
    reset_to_fulldesk
  end
  
  def reset_to_fulldesk
    @cards = []
    @@fulldesk.each { |card| @cards << card}
  end
  
  def take_random_card
    random_id = rand(@cards.size)
    card = @cards[random_id]
    @cards.delete_at(random_id)
    card
  end
end
