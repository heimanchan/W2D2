require_relative "cursor.rb"
require_relative "board.rb"

class Display
    def initialize(board)
        @cursor = Cursor.new([0,0], board)
        @cursor.get_input
    end

    def render
        until true
        end
    end

end

if __FILE__ == $PROGRAM_NAME
    board = Board.new
    display = Display.new(board)
    display.render
end