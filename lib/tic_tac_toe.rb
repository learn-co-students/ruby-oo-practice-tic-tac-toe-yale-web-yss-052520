class TicTacToe
    attr_accessor :board

    WIN_COMBINATIONS = [[0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [2,4,6]]

    def initialize
        @board = [" "]*9
    end

    def display_board
        puts "-----------"
        puts " #{board[0]} | #{board[1]} | #{board[2]} "
        puts " #{board[3]} | #{board[4]} | #{board[5]} "
        puts " #{board[6]} | #{board[7]} | #{board[8]} "
    end

    def input_to_index(input)
        input.to_i - 1
    end

    def move(index, token="X")
        board[index] = token
    end

    def position_taken?(index)
        !(board[index] == " ")
    end

    def valid_move?(index)
        (0..8).include?(index) && !position_taken?(index)
    end

    def turn
        display_board
        puts "Provide input between 1 and 9."
        input = gets.chomp
        index = input_to_index(input)
        if valid_move?(index)
            move(index, current_player)
        else
            puts "Invalid move."
            turn
        end
    end

    def turn_count
        board.reject {|i| i == " "}.count
    end

    def current_player
        turn_count.even? ? "X" : "O"
    end

    def won?
        x = board.map {|i| i == "X" ? 1 : 0}
        o = board.map {|i| i == "O" ? 1 : 0}

        x_result = WIN_COMBINATIONS.find {|combo| combo.map {|i| x[i] == 1}.all?}

        if x_result
            x_result
        else
            WIN_COMBINATIONS.find {|combo| combo.map {|i| o[i] == 1}.all?}
        end
    end

    def full?
        turn_count == 9
    end

    def draw?
        full? && !won?
    end

    def over?
        draw? || won?
    end

    def winner
        x = board.map {|i| i == "X" ? 1 : 0}
        o = board.map {|i| i == "O" ? 1 : 0}

        x_result = WIN_COMBINATIONS.find {|combo| combo.map {|i| x[i] == 1}.all?}

        if x_result
            "X"
        elsif y_result = WIN_COMBINATIONS.find {|combo| combo.map {|i| o[i] == 1}.all?}
            "O"
        else 
            nil
        end
    end

    def play
        until over?
            turn
        end

        if won?
            puts "Congratulations #{winner}!"
        else
            puts "Cat's Game!"
        end
    end
end