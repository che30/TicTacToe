require 'colorize'

class Player
  attr_reader :name, :token

  def initialize(name, token)
    @name = name
    @token = token
  end
end

class Grid
  attr_reader :board, :winner

  def initialize()
    @board = [1, 2, 3, 4, 5, 6, 7, 8, 9]
    @winner = nil
  end

  def board_display
    row1 = "| #{@board[0]} | #{@board[1]} | #{@board[2]} |\n".colorize(:light_blue)
    separator = "--------------\n".colorize(:light_blue)
    row2 = "| #{@board[3]} | #{@board[4]} | #{@board[5]} |\n".colorize(:light_blue)
    row3 = "| #{@board[6]} | #{@board[7]} | #{@board[8]} |\n".colorize(:light_blue)
    row1 + separator + row2 + separator + row3
  end

  def update_board(player, position)
    @board[position] = player.token
  end

  def player_position(player)
    @board.each_with_index
      .select { |val, _index| val == player.token }
      .map { |row| row[1] }
  end

  def winner?(player1, player2)
    winning_conditions = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 4, 8], [2, 4, 6], [0, 3, 6], [1, 4, 7], [2, 5, 8]]
    x_position = player_position(player1)
    y_position = player_position(player2)
    if winning_conditions.include?(x_position)
      @winner ||= player1
    elsif winning_conditions.include?(y_position)
      @winner ||= player1
    elsif @board.all?(String)
      @winner = 'draw'
    end
    @winner
  end

  def check_valid?(position)
    return false if @board[position] == 'X' || @board[position] == 'O'

    true
  end
end
