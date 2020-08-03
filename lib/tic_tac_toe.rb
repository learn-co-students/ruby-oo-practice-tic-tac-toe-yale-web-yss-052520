class TicTacToe 
    attr_accessor :board

    WIN_COMBINATIONS = [[0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [2,4,6]]

    def initialize(board = [" "," "," "," "," "," "," "," "," "])
        @board = board
    end 

    def display_board
        puts "-----------"
        puts " #{board[0]} | #{board[1]} | #{board[2]} "
        puts "- - - - - - "
        puts " #{board[3]} | #{board[4]} | #{board[5]} "
        puts "- - - - - - "
        puts " #{board[6]} | #{board[7]} | #{board[8]} "
        puts "-----------"
    end

    def input_to_index(input)
        input.to_i - 1
    end

    def move(index, token= 'X')
        board[index] = token 
    end 

    def position_taken?(index)
        !(board[index] == " ")
    end

    def valid_move?(position)
        position.between?(0, 8) && !position_taken?(position)
    end

    def turn
        display_board
        puts "What is your move?"
        input = gets.chomp
        index = input_to_index(input)
        if valid_move?(index)
            move(index, current_player)
        else
            puts "Move is invalid."
            turn
        end
    end

    def turn_count 
        board.count("X") + board.count("O")
    end 


    def current_player 
        turn_count.even? ? "X" : "O"
    end 

    def won?
        WIN_COMBINATIONS.each do |combination|
            if @board[combination[0]] == @board[combination[1]] && @board[combination[1]] == @board[combination[2]] && @board[combination[0]] != " "
                display_board
                return combination
            end
        end
        return false
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
        won? ? @board[won?[0]] : nil
    end

    def play
        until over?
            turn
        end
        won? ? (puts "Congratulations #{winner}!") : (puts "Cat's Game!")

    end

end