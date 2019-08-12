
module Players
  class Human < Player
    def move(board)
      board.turn_count
      gets.strip
      #suspect there's something wrong here
    end
  end

  class Computer < Player
    def move(board)
      board.turn_count
      collection = []
      board.cells.each_with_index{|cell, index| cell == " "
        collection << "#{index + 1}"
      }
      collection[rand(collection.size - 1)]
    end
  end
end
