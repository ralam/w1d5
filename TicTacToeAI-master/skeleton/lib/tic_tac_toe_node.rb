require_relative 'tic_tac_toe'
require "byebug"

class TicTacToeNode
  attr_accessor :board, :next_mover_mark, :prev_move_pos
  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    if next_mover_mark == :x
      @this_mark = :o
    else
      @this_mark = :x
    end

    if prev_move_pos.nil?
      @prev_move_pos = []
    else
      @prev_move_pos = prev_move_pos.dup
    end
  end

  def losing_node?(evaluator)
    if @board.over? && (@board.winner == evaluator || @board.winner.nil?)
      return false
    end
    true
  end

  def winning_node?(evaluator)
  end
  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    #until all 9 checks
    childs = []
    3.times do |row|
      3.times do |col|
        move = [row, col]
        if @board.empty?(move)
          new_board = @board.dup
          new_board[move] = @next_mover_mark
          new_pos = @prev_move_pos.dup
          new_pos += move
          childs << TicTacToeNode.new(new_board, @this_mark, new_pos)
        end
      end
    end
    childs
  end
end
