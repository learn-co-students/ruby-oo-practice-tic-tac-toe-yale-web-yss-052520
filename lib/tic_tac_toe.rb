class TicTacToe

    WIN_COMBINATIONS = [
        [0,1,2],
        [3,4,5],
        [6,7,8],
        [0,3,6],
        [1,4,7],
        [2,5,8],
        [0,4,8],
        [2,4,6]
    ]

    def initialize
        @board = [" "," "," "," "," "," "," "," "," "]
    end

    def display_board

        puts(" " + @board[0] + " | " + @board[1] + " | " + @board[2] + " ")
        puts("-----------")
        puts(" " + @board[3] + " | " + @board[4] + " | " + @board[5] + " ") 
        puts("-----------")
        puts(" " + @board[6] + " | " + @board[7] + " | " + @board[8] + " ") 
    end

    def input_to_index(s)
        index = s.to_i - 1
    end

    def move(index, token = "X")
        @board[index] = token

    end

    def position_taken?(index)
        if @board[index] == ' '
            false
        else 
            true
        end
    end

    def valid_move? (index)
        if index < 0 || index > 8
            false
        elsif position_taken?(index)
            false
        else
            true
        end
    end
    
    def turn_count
        9 - @board.count(" ")
    end

    def current_player
        if turn_count % 2 == 0
            return "X"
        else
            return "O"
        end
    end

    def turn
        puts "Please specify position between 1-9"
        input = gets
        index = input_to_index(input)
        if valid_move?(index)
            move(index, current_player)
            display_board
        else
            turn
        end
    end

    def won?
        WIN_COMBINATIONS.each do |combination|
            if @board[combination[0]] == @board[combination[1]] && @board[combination[1]] == @board[combination[2]] && @board[combination[0]] != " "
                return combination
            end
        end
        return false
    end

    def full?
        @board.each do |index|
            return false if index == " "
        end
        return true
    end
    
    def draw?
        return true if full? && !won?
        return false if won?
        return false if !full? && !won? 
    end

    def over?
        if full? || won?
            return true
        else
            return false
        end
        
    end

    def winner
        if won? == false
            return nil
        else
            @board[won?[0]]
        end
    end

    def play
        until over? || draw? do
           turn
        end

        if won?
            puts "Congratulations #{winner}!"
        elsif draw?
            puts "Cat's Game!"
        end
    end
end
