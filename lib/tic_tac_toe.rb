class TicTacToe 
    attr_accessor :board 

    def initialize(board = [" "," "," "," "," "," "," "," "," "])
        @board = board
    end 

    WIN_COMBINATIONS = [
        [0,1,2], [3,4,5], 
        [6,7,8], [0,3,6], 
        [1,4,7], [2,5,8], 
        [0,4,8], [6,4,2]]

    def display_board 
        puts " #{board[0]} | #{board[1]} | #{board[2]} "
        puts "-----------"
        puts " #{board[3]} | #{board[4]} | #{board[5]} "
        puts "-----------"
        puts " #{board[6]} | #{board[7]} | #{board[8]} "
    end   
    
    def input_to_index(string)
        string.to_i - 1
    end 
    
    def move(index, token= 'X')
        board[index] = token 
    end 

    def position_taken?(index)
        board[index] != " "
    end 

    def valid_move?(position)
        position.between?(0, 8) && !position_taken?(position)
    end

    def turn 
        puts "What is your move?"
        input = gets
        index = input_to_index(input)
        while !valid_move?(index)
            puts "Input not valid. Try again."
            input = gets
            index = input_to_index(input)
        end 
        move(index, current_player)
        display_board
    end 

    def turn_count 
        board.count("X") + board.count("O")
    end 

    def current_player 
        turn_count.even? ? "X" : "O"
    end 

    def won?
        WIN_COMBINATIONS.each do |combo|
            test_array = [board[combo[0]], board[combo[1]], board[combo[2]]]
            if test_array.uniq.count == 1 && test_array.first != " "
                return combo
            end
        end
        false
    end

    def full?
        turn_count == 9
    end

    def draw?
        !won? && full?
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
        until over?
            turn
        end

        if won?
            puts "Congratulations #{winner}!"
        else draw?
            puts "Cat's Game!"
        end
    end

end 