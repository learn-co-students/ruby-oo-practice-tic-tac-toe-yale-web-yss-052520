class TicTacToe

    attr_accessor :board

    def initialize(board = [" "," "," "," "," "," "," "," "," "])
        @board = board
    end

    WIN_COMBINATIONS = [
        [0,1,2],  # Top row
        [3,4,5],  # Middle row
        [6,7,8],  # Bottom row
        [0,3,6],  # Top column
        [1,4,7],  # Middle column
        [2,5,8],  # Bottom column
        [0,4,8],  # Negative-slope diagonal
        [2,4,6],  # Positive-slope diagonal
    ]
    def display_board
        puts " #{board[0]} | #{board[1]} | #{board[2]} "
        puts "-----------"
        puts " #{board[3]} | #{board[4]} | #{board[5]} "
        puts "-----------"
        puts " #{board[6]} | #{board[7]} | #{board[8]} "
    end

    def input_to_index(input)
        input.to_i - 1
    end

    def move(index, sign)
        board[index] = sign
    end

    def position_taken?(index)
        board[index] != " "
    end

    def valid_move?(index)
        board[index] == " " && (index).between?(0,8)
    end

    def turn_count
        board.count{|position|position != " " }
    end

    def current_player
        turn_count.even?  ? "X" : "O"
    end
    
    def turn
        input = gets.chomp
        index = input_to_index(input)
        if valid_move?(index)
          move(index, current_player)
          display_board
        else
          turn
        end
    end

    def won?
        WIN_COMBINATIONS.any? do |combo|
            if board[combo[0]] == board[combo[1]] && board[combo[0]] == board[combo[2]] && position_taken?(combo[0])
                return WIN_COMBINATIONS.find{|combo|board[combo[0]] == board[combo[1]] && board[combo[0]] == board[combo[2]]}
            end
        end
    end
       
    def full?
        turn_count == 9
        # board.all? {|position| position == "X" || position == "O"}
    end

    def draw?
        !won? && full?
    end

    def over?
        draw? || won? || full?
    end

    def winner
        won? && board[won?[0]] != " " ? board[won?[0]] : nil
        
        # if won? && board[won?[0]] != " " 
        #     board[won?[0]] 
        # else nil
        # end
    end
    
    def play
        until over?
            turn
            draw?
        end
        if won?
            puts "Congratulations #{winner}!"
        elsif draw?
            puts "Cat's Game!" 
        end 
    end 

  end