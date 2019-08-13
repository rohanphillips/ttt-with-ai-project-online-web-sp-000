class Game
  attr_accessor :board, :player_1, :player_2
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

    PLAYER_TOKENS = ["X", "O"]
    @winningcombo = -1

    def initialize(player_1 = Players::Human.new("X"), player_2 = Players::Human.new("O"), board = "")
      @player_1 = player_1
      @player_2 = player_2
      if board == ""
        @board = Board.new
      else
        @board = board
      end
    end

    def board
      @board
    end

    def current_player
    xcount = 0
    ocount = 0
    currentplayer = "X"

    if board.turn_count() < 10
      board.cells.each do |n|
        if n == "X"
          xcount += 1
        elsif n == "O"
          ocount += 1
        end
      end
      if xcount > ocount
        currentplayer = "O"
      end
    end
    if @player_1.token == currentplayer
      return @player_1
    else
      return @player_2
    end
  end

  def won?
    result = winner
    if result == nil
      return false
    end
    return WIN_COMBINATIONS[@winningcombo]
  end
  def winner()
    winnerfound = false
    PLAYER_TOKENS.each do |i|
      if iswinner(i) == i
        return i
        winnerfound = true
        break
      end
    end
    if winnerfound == false
      return nil
    end
  end
  def iswinner(player)
    winfound = false
    complete = false
    combo = []
    combinationcounter = 0

    until complete == true
      while combinationcounter < WIN_COMBINATIONS.length
        combo = WIN_COMBINATIONS[combinationcounter]
        combocounter = 0
        playercounter = 0
        while combocounter < combo.length
         boardcontent = board.cells[combo[combocounter]]
          if boardcontent == player
            playercounter += 1
          end
          combocounter += 1
        end
        if playercounter == 3
          winfound = true
          complete = true
          @winningcombo = combinationcounter
          break
        end
        combinationcounter += 1
      end
      complete = true
    end
    if winfound == true
      return player
    end
  end

  def full?()
    isfull = true
    board.cells.each do |location|
      if location == " "
        isfull = false
        break
      end
    end
    return isfull
  end

  def draw?
    result = won?
    isarray = result.class == Array
    fullboard = full?
    if result == false && fullboard == true
      #board is full and no winner
      return true
    elsif result
      #there was a winner, therefore no draw
      return false
    elsif result == false && fullboard == false
      #game is still in progress
      return false
    else
        #any other result would suggest a draw
        return true
    end
  end

  def over?
    return draw? == true || won? != false || full? == true
  end


  def turn()
   valid = false
   while valid == false
    puts "Please enter 1-9:"
    mymove = current_player.move(board)
    if board.valid_move?(mymove)
      if board.taken?(mymove) == false
        board.update(mymove, current_player)
        valid = true
      end
    end
   end
   board.display
  end

  def play
    isover = over?
    if isover == false
      puts "Welcome to Tic Tac Toe!"
      board.display
      while isover == false
        puts "It's player #{current_player.token}'s turn"
        turn
        result = won?
        isover = over?
      end
    end

    if isover
      result = won?
      if result
        puts "Congratulations #{winner}!"
      end
      if draw? == true
        puts "Cat's Game!"
      end
    end
  end

  def start
    user_input = ""


    while user_input != "exit"
      puts "Welcome to Tic Tac Toe Game Selector"
      puts "What kind of game would you like to play, 0, 1 or 2 players?"
      puts "Please enter your selection - exit ends this session"
      player_selection = 0
      user_input = gets.strip

      while (player_selection < 1 || player_selection > 2) && user_input != "exit"
        puts "Which player (1 or 2) will play first and be X?"
        player_selection = gets.strip.to_i
      end

      case user_input
        when "0"
          puts "Option 0 selected, Player #{player_selection} will play first"
          player_1 = Players::Computer.new("X")
          player_2 = Players::Computer.new("O")
          newgame = Game.new(player_1, player_2, Board.new).play
        when "1"
          puts "Option 1 selected, Player #{player_selection} will play first"
          case player_selection
            when 1
              player_1 = Players::Human.new("X")
              player_2 = Players::Computer.new("O")
            when 2
              player_1 = Players::Computer.new("O")
              player_2 = Players::Human.new("X")
          end
          newgame = Game.new(player_1, player_2, Board.new).play
        when "2"
          puts "Option 2 selected, Player #{player_selection} will play first"
          case player_selection
            when 1
              player_1 = Players::Human.new("X")
              player_2 = Players::Human.new("O")
            when 2
              player_1 = Players::Human.new("O")
              player_2 = Players::Human.new("X")
          end
          newgame = Game.new(player_1, player_2, Board.new).play
      end

    end
  end

end
