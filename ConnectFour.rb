class ConnectFour
  def initialize
    intro()
    createBoard()
    createMoveHash()
  end

  def intro
    puts "Connect Four is a two-player connection game in which players first choose"
    puts "a color and then take turns dropping one colored disc from the top into seven-column"
    puts "six-row vertically suspended grid. The pieces fall straight down, occupying the lowest space"
    puts "in the column. The objective is to form a horizontal, vertical or diagonal line of four first."
    puts "=============================================================================================="
  end

  def createHorizontalLinkBoard
    # The connect four board is made up of 6 rows and 7 columns
    @root = BoardSpace.new(0,0)
    @current = @root
    for i in 1..6
      for j in 1..7
        space = BoardSpace.new(i,j)
        space.leftNode(space)
        @current.rightNode(space)
        @current = space
      end
    end
  end

  def createBoard
    createHorizontalLinkBoard()
    createVerticalLinkBoard()
    createDiagonalLeftLinkBoard()
    createDiagonalRightLinkBoard()
  end

  def createVerticalLinkBoard
    # Start in column 1 and change the row first
    for i in 1..6
      for j in 1..6
        current = find(j,i)
        current.upNode(find(j+1,i))
      end
    end
  end

  def createDiagonalLeftLinkBoard
    for i in 1..5
      for j in 2..7
        current = find(i,j)
        current.leftUpNode(find(i+1,j-1))
      end
    end
  end

  def createDiagonalRightLinkBoard
    for i in 1..5
      for j in 1..6
        current = find(i,j)
        current.rightUpNode(find(i+1,j+1))
      end
    end
  end

  def find(row, col)
    @current = @root
    while !@current.nil?

      if (@current.row == row && @current.column == col)
        return @current

      else
        @current = @current.right

        if @current.nil?
          return false
        end

      end
    end
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
    if (checkRight() || checkUp() || checkRightUp() || chickLeftUp())
      return true
    else
      return false
    end
  end

  def checkRight(marker)
    for i in 1..6
      for j in 1..3
        # If we are in the third column and not consectutice, cannot finish 4 in a row.
        current = find(i,j)
        markerCount = 0

        while (current.marker == marker && current.right.marker == marker)
          markerCount += 1
          current = current.right

          if markerCount == 4
            return markerCount
          end

        end
      end
    end
  end
 
  def checkUp(marker)
    for i in 1..7
      for j in 1..2
        # If the second row does not have two in a row, cannot make 4 going up
        markerCount = 0
        current = find(j,i)

        while (current.marker == marker && current.up.marker == marker)
          markerCount += 1
          current = current.up

          if markerCount == 4
            return markerCount
          end

        end
      end
    end
  end

  def checkRightUp(marker)
    for i in 1..2
      for j in 1..3
        current = find(i,j)
        markerCount = 0
        
        while (current.marker == marker && current.rightUp.marker == marker)
          markerCount += 1
          current = current.rightUp

          if markerCount == 4
            return markerCount
          end
        end
      end
    end
  end

  def checkLeftUp(marker)
    for i in 1..2
      for j in 4..7
        current = find(i,j)
        markerCount = 0

        while (current.marker == marker && current.leftUp.marker == marker)
          markerCount += 1
          current = current.leftUp

          if markerCount == 4
            return markerCount
          end

        end
      end
    end
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

class BoardSpace
  attr_accessor :row, :column, :next, :marker, :left, :leftUp, :up, :rightUp, :right

  def initialize(row, column)
    @column = column
    @row = row
    @next = nil
    @marker = nil

    @left = nil
    @leftUp = nil
    @up = nil
    @rightUp = nil
    @right = nil
  end

  def placeMarker(marker)
    @marker = marker
  end

  def rightNode(node)
    @right = node
  end

  def leftNode(node)
    @left = node
  end

  def upNode(node)
    @up = node
  end

  def rightUpNode(node)
    @rightUp = node
  end

  def leftUpNode(node)
    @leftUp = node
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