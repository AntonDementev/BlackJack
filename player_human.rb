class PlayerHuman < Player
  attr_reader :name
  def ask_name
    puts 'Введите ваше имя:'
    @name = gets.chomp
  end
end
