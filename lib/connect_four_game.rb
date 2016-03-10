require_relative 'connect_four_grid'
require_relative 'player'

class ConnectFourGame
  attr_reader  :player1, :player2, :play_column_num, :last_row_played
  attr_accessor :game_grid



  def initialize
    @game_grid = ConnectFourGrid.new
    @player1 = Player.new("X")
    @player2 = Player.new("O")
    @play_column_num = nil
    @last_row_played = nil
    @play_again = nil
  end



  def play_game
    if !@play_again
      puts "Let's play Connect Four!\n\n"
      player_name(@player1)
      puts

      player_name(@player2)
      puts
    else
      @play_again = nil
    end

    grid_sum

    while true
      select_column(@player1)
      until column_moves_left?
        puts "That column is full.  Pick another column."
        select_column(@player1)
      end

      move(@player1)

      grid_sum

      if vertical_win?(@player1) || horizontal_win?(@player1)
        puts "Connect Four! #{@player1.name} wins!"
        return
      end

      if grid_full?
        puts "Sorry, no more moves left. It's a draw."
        if play_again?
          @play_again = true
          clear_grid
          play_game
          return
        else
          return
        end
      end

      select_column(@player2)
      until column_moves_left?
        puts "That column is full.  Pick another column."
        select_column(@player2)
      end

      move(@player2)

      grid_sum

      if vertical_win?(@player2) || horizontal_win?(@player2)
        puts "Connect Four! #{@player2.name} wins!"
        return
      end

      if grid_full?
        puts "Sorry, no more moves left. It's a draw."
        if play_again?
          @play_again = true
          clear_grid
          play_game
          return
        else
          return
        end
      end
    end
  end

private

  def valid_column?
    @play_column_num.between?(1, @game_grid.columns)
  end

  def player_name(player)
    puts "Player, what is your name?"
    player.name = gets.chomp
  end

  def select_column(player)
    while true
      print "#{player.name}, which column do you want to play? (1, 2, 3, 4, 5, 6, 7): "
      @play_column_num = gets.chomp.to_i
      if !valid_column?
        puts "invalid play, try again"
      else
        break
      end
    end
  end

  def column
    @game_grid.column(@play_column_num)
  end

  def column_moves_left?
    column.each do |piece|
      if piece == " "
        return true
      end
    end
    return false
  end

  def reversed_grid
    @game_grid.reversed
  end

  def move(player)
    reversed_grid.each_with_index do |row, row_index|
      row.each_with_index do |square, col_index|
        if col_index == @play_column_num - 1 && square == " "
        reversed_grid[row_index][col_index] = player.game_piece
        @last_row_played = row_index
          return
        end
      end
    end
  end

  def grid_sum
    @game_grid.print_grid
  end

  def row
    @game_grid.row(@last_row_played)
  end

  def horizontal_win?(player)
    match = 0
    row.each do |square|
      if square == player.game_piece
        match += 1
      else
        unless match == 4
          match = 0
        end
      end
    end
    if match == 4
      return true
    else
      return false
    end
  end

  def vertical_win?(player)
    match = 0
    column.each do |square|
      if square == player.game_piece
        match += 1
      else
        unless match == 4
        match = 0
        end
      end
    end
    if match == 4
      return true
    else
      return false
    end
  end

  def grid_full?
    empty_squares = 0
    @game_grid.grid.each do |row|
      row.each do |square|
        if square == " "
          empty_squares += 1
        end
      end
    end
    if empty_squares == 0
      return true
    else
      return false
    end
  end

  def play_again?
    while true
      print "Would you like to play again? (y/n): "
      answer = gets.chomp.downcase
      if answer == 'y'
        return true
      elsif answer == 'n'
        return false
      else
        puts "invalid answer."
      end
    end
  end

  def clear_grid
  @game_grid.grid = @game_grid.create_grid
  end

  # def select_column(player)
  #   print "#{player.name} which column would you like to play?"
  #   @play_column_num = gets.to_i
  #   until @play_column_num.between?(1, @game_grid.columns)
  #     puts "Invalid column, please choose again."
  #     @play_column_num = gets.to_i
  #   end
  # end
end
