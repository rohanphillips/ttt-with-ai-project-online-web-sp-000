require 'pry'
class Board
  attr_accessor :cells

  def initialize
    reset!
  end

  def reset!
    @cells = Array.new(9, " ")
  end

  def display
    puts " #{@cells[0]} | #{@cells[1]} | #{@cells[2]} "
    puts "-----------"
    puts " #{@cells[3]} | #{@cells[4]} | #{@cells[5]} "
    puts "-----------"
    puts " #{@cells[6]} | #{@cells[7]} | #{@cells[8]} "
  end

  def position(position)
    @cells[position.to_i - 1]
  end

  def full?()
    isfull = true
    @cells.each do |location|
      if location == " "
        isfull = false
        break
      end
    end
    return isfull
  end

  def turn_count
    turncount = 0
    @cells.each{|cell|
      if cell != " "
        turncount += 1
      end
    }
    return turncount
  end

  def taken?(index)
    !(@cells[index.to_i - 1].nil? || @cells[index.to_i - 1] == " ")
  end

  def valid_move?(move)
    will_return = false
    if move.to_i.between?(1,9) && move != "invalid"
      will_return = taken?(move.to_i) == false ? true : false
    end
    will_return
  end

  def update(cell, player)
    @cells[cell.to_i - 1] = player.token
  end

end
