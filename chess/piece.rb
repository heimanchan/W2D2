require "byebug"
require_relative "board.rb"
require "Singleton"

module Validation
    def valid_pos?(pos)
        x, y = pos
        #if x >= 8 || y >= 8 || x < 0 || y < 0
        if x.between?(0,7) && y.between?(0,7)
            return true
        else
            return false
        end
    end
end

module SlidingPiece
    def all_positions(pos, directions)
        available_moves = []

        directions.each do |direction|
            puts "#{direction}"
            next_pos = pos
            while true 
                next_pos =  Piece.send(direction, next_pos)
                break unless valid_pos?(next_pos) 
                
                break if @board[next_pos].color == @board[pos].color #friendly
                if @board[next_pos].is_a?(NullPiece)
                    available_moves << next_pos
                    next
                end
                if @board[next_pos].color != @board[pos].color #enemy
                    available_moves << next_pos 
                    break
                end 
                # available_moves << next_pos
            end
        end 
        available_moves
    end

    def moves 
        available_moves = []
        slopes = move_dirs #:horizontal , :vertical, :diagonal

        start_pos = @pos
        slopes.each do |slope|
            case 
            when slope == :horizontal
                available_moves += all_positions(start_pos, [:left, :right])
            when slope == :vertical
                available_moves += all_positions(start_pos, [:up, :down])
            when slope == :diagonal
                available_moves += all_positions(start_pos, [:up_left, :up_right, :down_left, :down_right])
            end
        end
        
        available_moves
    end
end

module SteppingPiece
    def moves
        diffs = move_diffs
    end
end

class Piece
    attr_accessor :symbol, :color, :board, :pos

    def initialize(board, pos)
        @board = board
        @pos = pos
        @board[pos] = self
    end

    def self.left(pos)
        #[1,2] => [1,1]
        [pos[0], pos[1]-1]
    end

    def self.right(pos)
        [pos[0], pos[1]+1]
    end

    def self.up(pos)
        [pos[0]+1, pos[1]]
    end

    def self.down(pos)
        [pos[0]-1, pos[1]]
    end
    def self.up_left(pos)
        Piece.up(Piece.left(pos))
    end
    def self.up_right(pos)
        Piece.up(Piece.right(pos))
    end
    def self.down_left(pos)
        Piece.down(Piece.left(pos))
    end
    def self.down_right(pos)
        Piece.down(Piece.right(pos))
    end
    
end

class Bishop < Piece
    include SlidingPiece
    include Validation

    def initialize(board, position, color)
        super(board, position)
        @color = color
        @symbol = "♝"
    end

    def to_s
        @symbol.to_s
    end
    def move_dirs
        return [:diagonal]
    end
end

class Rook < Piece
    include SlidingPiece
    include Validation

    def initialize(board, position, color)
        super(board, position)
        @color = color
        @symbol = "♜"
    end

    def to_s
        # "♜"
        @symbol.to_s
    end

    def move_dirs
        return [:horizontal, :vertical]
    end   
end

class Queen < Piece
    include SlidingPiece
    include Validation

    def initialize(board, position, color)
        super(board, position)
        @color = color
        @symbol = "♛"
    end

    def to_s
        @symbol.to_s
    end

    def move_dirs
        return [:diagonal, :horizontal, :vertical]
    end
end

class Knight < Piece

    def initialize(board, position, color)
        super(board, position)
        @color = color
        @symbol = "♞"
    end

    def to_s
        @symbol.to_s
    end

    def move_diffs
    end
end

class King < Piece
    def initialize(board, position, color)
        super(board, position)
        @color = color
        @symbol = "♚"
    end

    def to_s
        @symbol.to_s
    end

    def move_diffs
        [[0, -1],[0, 1],[-1, 0], [1, 0],[-1,-1],[-1,1],[1,-1],[1,1]]
    end
end

class NullPiece < Piece
    attr_reader :color, :symbol

    include Singleton
    def initialize
        @color
        @symbol
    end

    def to_s
        " "
    end
end

if __FILE__ == $PROGRAM_NAME
    board = Board.new
    pos = [0,0]

    test = Rook.new(board, pos, :red)
    
    friendly = Rook.new(board, [0,2], :red)

    enemy = Rook.new(board, [2,0], :blue)
    p test.moves

end