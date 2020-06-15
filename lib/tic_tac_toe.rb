class TicTacToe

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
    FRAME = [
        "|", "|",
        "-----------",
        "|", "|",
        "-----------",
        "|", "|", ""]

    def initialize
        @board = []
        9.times do
            @board << " "
        end
    end

    def display_board
        (0..8).each_with_object("") do |i, output|
            output << " #{@board[i]} "
            output << FRAME[i]
            puts output
        end
    end

    def input_to_index(input)
        input.to_i - 1
    end

    def move(index, token = "X")
        @board[index] = token
    end

    def position_taken?(index)
        @board[index] != " "
    end

    def valid_move?(index)
        index.between?(0, 8) && !self.position_taken?(index)
    end

    def turn_count
        @board.count{|p| p != " "}
    end

    def current_player
        if self.turn_count.even?
            "X"
        else
            "O"
        end
    end

    def turn
        index = nil
        loop do
            puts "Enter your move"
            input = gets.chomp
            index = input_to_index(input)
            break if valid_move?(index)
            puts "Invalid move"
        end
        self.move(index, self.current_player)
        self.display_board
    end

    def won?
        WIN_COMBINATIONS.find do |combo|
            combo.map{|index| @board[index]}.uniq.size == 1 && combo.none?{|index| @board[index] == " "}
        end
    end

    def full?
        self.turn_count == 9
    end

    def draw?
        self.full? && !self.won?
    end

    def over?
        3.times do self.draw? end
        self.draw? || self.won?
    end

    def winner

        win_player = @board[WIN_COMBINATIONS.find{|combo| combo.map{|index| @board[index]}.uniq.size == 1}[0]]
        if win_player == " "
            nil
        else
            win_player
        end            
    end

    def play
        until self.over? do
            self.turn
        end

        if self.won?
            puts "Congratulations #{self.winner}!"
        elsif self.draw?
            puts "Cat's Game!"
        end
    end
end
