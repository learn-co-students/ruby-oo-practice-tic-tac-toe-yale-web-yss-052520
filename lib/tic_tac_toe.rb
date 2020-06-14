class TicTacToe

    WIN_COMBINATIONS = [
        [0,1,2], # Top row
        [3,4,5],  # Middle row
        [6,7,8], # Bottom row
        [0,3,6],  # First column
        [1,4,7],  # Second column
        [2,5,8],  # Third column
        [0,4,8],  # Top left diagonal
        [6,4,2]  # Top right diagona
    ]

    def initialize
        @board = [" "," "," "," "," "," "," "," "," "]
    end

    def display_board
        3.times.each {|row|
        
            puts " #{@board[ 3 * row]} | #{@board[3 * row + 1]} | #{@board[3 * row + 2]} "
            puts "-----------"
        }
    end

    def input_to_index(input)
        input.to_i - 1
    end

    def move(index, token = "X")
        @board[index] = token
    end

    def position_taken?(index)
        return @board[index] == "X" || @board[index] == "O"
    end

    def valid_move?(pos)
        (pos >= 0 && pos <= 8) && !position_taken?(pos)
    end

    def turn

        input = gets.chomp
        puts "Provide an index from 1-9 to place your token"
        index = input_to_index(input)
        while (!valid_move?(index))
            input = gets.chomp
            puts "Provide an index from 1-9 to place your token"
            index = input_to_index(input)
        end
        move(index, current_player)
        display_board

    end
    
    def turn_count
        @board.count("X") + @board.count("O")
    end

    def current_player
        (turn_count % 2 == 0)? "X" : "O"
    end

    def won?
        win = false
        WIN_COMBINATIONS.each{|arr| 
            win = arr if(@board[arr[0]] == "X" && @board[arr[1]] == "X" && @board[arr[2]] == "X")
            win = arr if(@board[arr[0]] == "O" && @board[arr[1]] == "O" && @board[arr[2]] == "O")
        } 
        win
    end

    def full?
        turn_count == 9
    end

    def draw?
        full? && !won?
    end

    def over?
        won? || full?
    end

    def winner
        winner = nil
        WIN_COMBINATIONS.each{|arr| 
        winner = "X" if(@board[arr[0]] == "X" && @board[arr[1]] == "X" && @board[arr[2]] == "X")
        winner = "O" if(@board[arr[0]] == "O" && @board[arr[1]] == "O" && @board[arr[2]] == "O")
    }      
    winner
    end

    def play 
        while(!over?)
            turn
            if(draw? || won?)
                break
            end
        end

        if(won?)
            puts "Congratulations #{winner}!"
        else
            puts "Cat's Game!"
        end

    end


end