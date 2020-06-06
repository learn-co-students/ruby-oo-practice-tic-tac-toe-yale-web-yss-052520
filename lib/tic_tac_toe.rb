require 'pry'
class TicTacToe 
    attr_accessor :board 

    BOARD_WIDTH = 3
    BOARD_HEIGHT = 3

    WIN_COMBINATIONS = [
        [0, 1, 2],
        [3, 4, 5],
        [6, 7, 8],
        [0, 3, 6],
        [1, 4, 7],
        [2, 5, 8],
        [0, 4, 8],
        [2, 4, 6]
    ]

    def initialize()
        @board = [" "] * 9
    end

    def display_board
        display(self.board)
    end

    def input_to_index(board_index)
        board_index.to_i - 1
    end

    def move(index, token = "X")
        self.board[index] = token 
    end

    def position_taken?(index)
        !(board[index] == " ")
    end

    def valid_move?(index)
        in_range?(index) && !position_taken?(index)
    end

    def turn_count()
        board.count{|piece| piece != " "}
    end

    def current_player()
        turn_count() % 2 == 0 ? "X" : "O"
    end

    def won?
        WIN_COMBINATIONS.each{|comb| return comb if is_winning_match?(comb)}
        false
    end

    def full?()
        turn_count() == 9
    end
    
    def draw?()
        full?() && !won?()
    end

    def over?()
        full?() || won?()
    end

    def winner()
        is_winner = won?()
        is_winner ? board[is_winner[0]] : nil
    end

    def turn
        puts "Where would you like to place your piece (A number between 1-9)"
        index = input_to_index(gets())

        while !(valid_move?(index))
            if position_taken?(index)
                puts "Position Taken! Pick another piece!"
                display_board()
            else 
                puts "Invalid Selection! Pick another piece!"
                display_positions()
            end
            index = input_to_index(gets())
        end
        move(index, current_player())
        display_board()
    end

    def play()
        while !draw? && !over?()
            turn()
        end
        puts draw?() ? "Cat's Game!" : "Congratulations #{winner()}!"
    end

    private 

    def in_range?(index)
        index >= 0 && index < self.board.length
    end

    def is_winning_match?(indices)
        first_index = self.board[indices[0]]
        return false if first_index == " "
        indices.map{|index| self.board[index]} == [first_index] * BOARD_WIDTH 
    end

    def display_positions()
        display([*1..9])
    end

    def display(disp_object)
        puts disp_object.each_slice(3).map { |row| " " + row.join(" | ")  + " "}.join("\n" + "-"*11 + "\n")
    end
end
