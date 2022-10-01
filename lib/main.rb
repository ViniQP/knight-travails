class Board

  def knight_moves(start_position, destination)
    current = make_tree(start_position, destination)
    history = []
    make_history(current, history, start_position)
    print_moves(history, start_position, destination)
  end

  def make_tree(start_position, destination)
    queue = [Knight.new(start_position)]
    current = queue.shift
    until current.position == destination
      current.check_moves.each do |move|
        current.children << knight = Knight.new(move, current)
        queue << knight
      end
      current = queue.shift
    end
    current
  end

  def make_history(current, history, start_position)
    until current.position == start_position
      history << current.position
      current = current.parent
    end
    history << current.position
  end

  def print_moves(history, start_position, destination)
    puts "You made it in #{history.size - 1} moves!"
    puts "To get from #{start_position} to #{destination} you must go through the following path:"
    history.reverse.each { |move| puts move.to_s }
  end
end

class Knight
  attr_accessor :parent, :position, :children

  MOVES = [[1, 2], [2, 1], [-1, -2], [-2, -1], [1, -2], [-1, 2], [2, -1], [-2, 1]]
  
  def initialize(position, parent = nil)
    @position = position
    @parent = parent
    @children =  []

  end

  def check_moves
    check_moves = MOVES.map do |move|
      move.each_with_index.map { |n, i| n + @position[i] unless (n + @position[i]).negative? || (n + position[i]) > 7 }
    end
    check_moves.delete_if { |move| move.include?(nil) }
  end
end

test = Board.new

test.knight_moves([0, 0], [6, 2])