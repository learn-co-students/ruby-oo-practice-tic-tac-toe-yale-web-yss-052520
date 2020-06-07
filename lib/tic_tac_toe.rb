require 'pry'

class TicTacToe
    attr_accessor :board

    WIN_COMBINATIONS = [
        [0,1,2], [3,4,5], [6,7,8], [0,3,6], 
        [1,4,7], [2,5,8], [0,4,8], [6,4,2]
    ]

    def initialize
        @board = []
        9.times {self.board.push(" ")}
    end

    def display_board
        puts " #{board[0]} | #{board[1]} | #{board[2]} \n-----------\n #{board[3]} | #{board[4]} | #{board[5]} \n----------- \n #{board[6]} | #{board[7]} | #{board[8]} "
    end

    def input_to_index(num_string)
        num_string.strip.to_i - 1
    end

    def move(index, token= "X")
        board[index] = token
    end

    def position_taken?(index)
        board[index] != " "
    end

    def valid_move?(index)
        # binding.pry
        index.between?(0, 8) && !position_taken?(index)
    end

    def turn
        puts "Your move?"
        number = gets
        index = input_to_index(number)
        # binding.pry

        while !valid_move?(index)
            # binding.pry
            puts "Sorry, invalid move"
            number = gets
            index = input_to_index(number)
        end

        move(index, current_player)
        display_board
        
    end

    def turn_count
        board.select{|space| space != " "}.count
    end

    def current_player
        return "X" if turn_count.even?
        return "O"
    end

    def won?
        WIN_COMBINATIONS.each do |test_combo|
            # binding.pry
            test_array = [board[test_combo[0]], board[test_combo[1]], board[test_combo[2]]]
            if test_array.uniq.count == 1 && test_array.first != " "
                return test_combo
            end
        end
        false
    end

    def full?
        !board.include?(" ")
    end

    def draw?
        full? && !won?
    end

    def over?
        draw? || won?
    end

    def winner
        if !over?
            return nil
        end
        win_combo = won?
        board[win_combo.first]
    end

    def play
        while !over?
            turn
        end

        if won?
            puts "Congratulations #{winner}!"
        else draw?
            puts "Cat's Game!"
        end
    end

end