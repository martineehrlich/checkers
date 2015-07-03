class Player
  attr_accessor :name
  def initialize(name)
    @name = name
  end

  def get_input
    puts "enter a starting position"
      position = gets.chomp
      position = parse(position)
    puts 'enter a list of moves'
      list = gets.chomp
      list = parse(list)
      [position, list]
  end

  def parse(input)
    input.split(",").map {|el| el.to_i}
  end

end
