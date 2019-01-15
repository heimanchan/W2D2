require_relative "cursor.rb"
require_relative "board.rb"
require "colorize"
require "colorized_string"

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
                    cursor_color = :light_blue
                end

                if !@board[pos].nil?
                    print "[x]".colorize(:color => cursor_color, :background => background_color)
                else
                    print "[ ]".colorize(:color => cursor_color, :background => background_color)
                end

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
    display = Display.new(board)
    display.test_render
end