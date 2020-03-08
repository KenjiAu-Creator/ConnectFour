class ConnectFour
  def initialize
    intro()
    createBoard()
    @currentPlayerId = 0
    createPlayers()
    play()
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
    for i in 1..7
      for j in 1..5
        current = findNext(j,i)
        current.upNode(findNext(j+1,i))
      end
    end
  end

  def createDiagonalLeftLinkBoard
    for i in 1..5
      for j in 2..7
        current = findNext(i,j)
        current.leftUpNode(findNext(i+1,j-1))
      end
    end
  end

  def createDiagonalRightLinkBoard
    for i in 1..5
      for j in 1..6
        current = findNext(i,j)
        current.rightUpNode(findNext(i+1,j+1))
      end
    end
  end

  def findNext(row, col)
    current = @root.right
    while !((current.row == row) && (current.column == col))
      if current.nil?
        return false
      else
        current = current.right
      end
    end
      
    return current
 
  end

  def find(row, col)
    row = row.to_i
    col = col.to_i
    if ((row < 1 || row > 6) || (col < 1 || col > 7))
      return false
    else
      current = @root.right
      while !(current.row == row)
        current = current.up
      end
      
      while !(current.column == col)
        current = current.right
      end

      return current
    end
  end

  def winCondition(marker)
    if (checkRight(marker) || checkUp(marker) || checkRightUp(marker) || checkLeftUp(marker))
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

          if markerCount == 3
            return true
          end

        end
      end
    end
    return false
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

          if markerCount == 3
            return true
          end

        end
      end
    end
    return false
  end

  def checkRightUp(marker)
    for i in 1..2
      for j in 1..3
        current = find(i,j)
        markerCount = 0
        
        while (current.marker == marker && current.rightUp.marker == marker)
          markerCount += 1
          current = current.rightUp

          if markerCount == 3
            return true
          end
        end
      end
    end
    return false
  end

  def checkLeftUp(marker)
    for i in 1..2
      for j in 4..7
        current = find(i,j)
        markerCount = 0

        while (current.marker == marker && current.leftUp.marker == marker)
          markerCount += 1
          current = current.leftUp

          if markerCount == 3
            return true
          end

        end
      end
    end
    return false
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
    current = find(1, column)

    while !(current.marker.nil?)
      current = current.up
    end

    current.marker = marker
  end

  def currentPlayer
    @players[@currentPlayerId]
  end

  def otherPlayerId
    1 - @currentPlayerId
  end

  def switchPlayers
    @currentPlayerId = otherPlayerId
    puts "Player #{@players[@currentPlayerId].marker}\'s turn."
    return @currentPlayerId
  end

  def play
    gameOver = false

    while !gameOver
      playerMove = getMove()
      playerMarker = currentPlayer.marker

      placeMove(playerMarker, playerMove)
      
      if winCondition(playerMarker)
        gameOver = true
        puts "Game over! #{playerMarker} wins!"
        break
      end

      switchPlayers()
    end

  end

  def createPlayers
    @players = [Player.new(0), Player.new(1)]
    @players[0].marker = "white"
    @players[1].marker = "black"
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

  def initialize(id)
    @id = id
    @marker = nil
  end

  def setMarker(marker)
    @marker = marker
  end
end

game = ConnectFour.new