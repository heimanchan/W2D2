require_relative "piece.rb"

class Board
    attr_reader :grid

    def initialize
        @grid = Array.new(8){[]}
        (0..1).each do |row|
            (0..7).each do |col|
                @grid[row]<< Piece.new
            end
        end

        (2..5).each do |row|
            (0..7).each do |col|
                @grid[row]<< nil
            end
        end

        (-2..-1).each do |row|
            (0..7).each do |col|
                @grid[row]<< Piece.new
            end
        end

        # p @board
    end

    def [](pos)
        x, y = pos
        grid[x][y]
    end

    def []=(pos, value)
        x, y = pos
        grid[x][y] = value
    end

    def move_piece(start_pos, end_pos)
        raise ArgumentError.new("There is no piece at start position.") if self[start_pos].nil?
        raise ArgumentError.new("There is a piece at end position.") if !self[end_pos].nil?
        self[end_pos] = self[start_pos]
        self[start_pos] = nil
    end
end

if __FILE__ == $PROGRAM_NAME
    board = Board.new

    pos_pawn1 = [1,0]
    pos_empty1 = [2,0]
    pos_tower = [0,0]


    p board[pos_pawn1]
    p board[pos_empty1]
    board.move_piece(pos_pawn1, pos_empty1)
    p board[pos_pawn1]
    p board[pos_empty1]
    # board.move_piece(pos_pawn1, pos_empty1)
    board.move_piece(pos_tower, pos_empty1)
    
    


end