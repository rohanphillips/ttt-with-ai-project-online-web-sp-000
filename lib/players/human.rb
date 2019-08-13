
module Players
  class Human < Player
    def move(board)
      board.turn_count
      gets.strip
      #suspect there's something wrong here
    end
  end

  class Computer < Player
    WIN_COMBINATIONS = [
      [0,1,2],
      [3,4,5],
      [6,7,8],
      [0,3,6],
      [1,4,7],
      [2,5,8],
      [0,4,8],
      [2,4,6]
      ]

    def inverse_token(token)
      case token
        when "X"
          return "O"
        when "O"
          return "X"
      end
    end
    def near_win?(board, with_token)
      nearwin = "false, -1, -1"
      WIN_COMBINATIONS.each.with_index{|combo, index|
        if (board.cells[combo[0]] == with_token && board.cells[combo[1]] == with_token && board.cells[combo[2]] == " ")
          return "true, #{index}, 0"
        elsif (board.cells[combo[0]] == " " && board.cells[combo[1]] == with_token && board.cells[combo[2]] == with_token)
          return "true, #{index}, 2"
        elsif (board.cells[combo[0]] == with_token && board.cells[combo[1]] == " " && board.cells[combo[2]] == with_token)
          return "true, #{index}, 1"
        end
      }
      nearwin
    end

    def move(board)
      board.turn_count
      collection = []
      board.cells.each_with_index{|cell, index| cell == " "
        collection << "#{index + 1}"
      }
      nearwin = near_win?(board, inverse_token(self.token)).split(", ")
      if nearwin[0] == "true"
        win_index = nearwin[1].to_i
        location = nearwin[2].to_i
        case location
          when 0
            play_location = WIN_COMBINATIONS[win_index][2] + 1
          when 2
            play_location = WIN_COMBINATIONS[win_index][0] + 1
          when 1
            play_location = WIN_COMBINATIONS[win_index][1] + 1
        end
      else
        play_location = collection[rand(collection.size - 1)]
      end
      play_location.to_s
    end
  end
end
