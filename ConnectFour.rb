class ConnectFour
  def initialize
    intro()
    create_board()
    createMoveHash()
  end

  def intro
    puts "Connect Four is a two-player connection game in which players first choose"
    puts "a color and then take turns dropping one colored disc from the top into seven-column"
    puts "six-row vertically suspended grid. The pieces fall straight down, occupying the lowest space"
    puts "in the column. The objective is to form a horizontal, vertical or diagonal line of four first."
    puts "=============================================================================================="
  end

  def create_board
    row = "| O | O | O | O | O | O | O |"
    6.times do
      puts row
    end
    puts "============================="
  end

  def createMoveHash()
    @moves = {
      1 => [],
      2 => [],
      3 => [],
      4 => [],
      5 => [],
      6 => [],
      7 => [],
    }
  end

  def winCondition
    @moves
  end

  def getMove()
    puts "Please enter the column which you wish to place the marker."
    playerMove = gets.chomp
    if (playerMove.to_i > 7 || playerMove.to_i < 1)
      puts "Invalid column. Please enter a column between 1-7 to play."
      getMove()
    else
      return playerMove
    end
  end

  def placeMove(marker, column)
    @moves[column].push(marker)
    return @moves
  end

  def currentPlayerId
    currentPlayer = currentPlayerId
  end

  def otherPlayerId
    1 - @currentPlayerId
  end

  def switchPlayers
    @currentPlayerId = otherPlayerId
    puts "Player #{marker}\'s turn."
    return @currentPlayerId
  end
  
end

class BoardSpace(row,col)
  def initialize
    @col = col
    @row = row
    @marker = nil
  end

  def placeMarker(marker)
    @marker = marker
  end
end

class Player
  attr_accessor :id, :marker

  def initialize
    @id = id
    @marker = marker
  end
end

game = ConnectFour.new