require_relative "cursor.rb"
require_relative "board.rb"
require_relative "piece.rb"
require "colorize"
require "colorized_string"
require "byebug"

class Display
    def initialize(board)
        @board = board
        @cursor = Cursor.new([0,0], board)
        # @cursor.get_input
        
    end

    def render
        system("clear")
        #p ColorizedString.colors
        (0...8).each do |row|
            (0...8).each do |col|
                added_index = row + col
                pos = [row, col]
                
                if added_index.even?
                    background_color = :light_black
                else
                    background_color = :light_white
                end

                if @cursor.cursor_pos == pos
                    if @cursor.selected
                        cursor_color = :yellow
                    else
                        cursor_color = :black
                    end
                else
                    cursor_color = @board[pos].color
                end
                @board[pos].to_s
                print "[#{@board[pos].to_s}]".colorize(:color => cursor_color, :background => background_color)
            end
            puts ""
        end
    end

    def test_render
        while true
            render
            @cursor.get_input
        end
    end
end

if __FILE__ == $PROGRAM_NAME
    board = Board.new
    
    pos = [0,0]
    test = Rook.new(board, pos, :red)
    friendly = Queen.new(board, [0,2], :red)
    enemy = Bishop.new(board, [2,0], :blue)

    display = Display.new(board)

    display.render
    p test.moves
end