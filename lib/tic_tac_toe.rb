require 'pry'

class TicTacToe
    attr_reader :board 

WIN_COMBINATIONS = [
    [0,1,2],
    [3,4,5],
    [6,7,8],
    [0,4,8],
    [2,4,6],
    [0,3,6],
    [1,4,7],
    [2,5,8]
]

    def initialize
        @board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
    end 

    def display_board 
        puts " #{board[0]} | #{board[1]} | #{board[2]} "
        puts "-----------"
        puts " #{board[3]} | #{board[4]} | #{board[5]} "
        puts "-----------"
        puts " #{board[6]} | #{board[7]} | #{board[8]} "
    end

    def input_to_index(str_num)
        str_num.to_i - 1
    end 

    def move(board_index, token='X')
        board[board_index] = token 
    end 

    def position_taken?(index)
        board[index] != " "
    end 

    def valid_move?(position)
        position >= 0 && position <= 8 && !position_taken?(position)
    end 

    def get_input 
        input = gets
        board_index = input_to_index(input)
    end 

    def turn 
        print "Please input a number between 1-9 for your move: "
        board_index = get_input
        while !valid_move?(board_index)
            print "Not valid input: Please try again: "
            board_index = get_input
        end 
        move(board_index, current_player)
        display_board
    end 

    def turn_count 
        board.count("X") + board.count("O")
    end 

    def current_player 
        turn_count.even? ? "X" : "O"
    end 

    def check_combo(combo)
        index1, index2, index3 = combo[0], combo[1], combo[2]
        board[index1] == "X" && board[index2] == "X" && board[index3] == "X" || board[index1] == "O" && board[index2] == "O" && board[index3] == "O"
    end 

    def won? 
        WIN_COMBINATIONS.each do |combo|
            if check_combo(combo) 
                return combo 
            end 
        end 
        false
    end 

    def full? 
        board.count("X") + board.count("O") == 9
    end 

    def draw?
        full? && !won? 
    end 

    def over? 
        won? || draw? 
    end 

    # assumes X goes first
    def winner 
        if won? 
            turn_count.even? ? "O" : "X"
        end 
    end 

    def play 
        puts "Welcome to Tic-Tac-Toe!"
        display_board
        until self.over? 
            turn 
        end 

        if won? 
            puts "Congratulations #{winner}!"
        elsif draw? 
            puts "Cat's Game!"
        end 
    end 
end 