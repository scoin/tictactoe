#!/usr/bin/env ruby

def player(board, aplayer) #returns players chosen place on the board and checks for correct input
x = '0'
    while x.to_i < 1 || x.to_i > 9 do
        puts "X, MOVE" if aplayer == 1
        puts "O, MOVE" if aplayer == 2

        x = gets.chomp
        break if x == 'quit'
        
        if (board[(x.to_i - 1)] == 'X') || (board[(x.to_i - 1)] == 'O')
            puts "already used, try again"
            printboard(board)
            x = '0'
        end
    end
return x
end

def switchplayer(aplayer) #switches player
    return 2 if aplayer == 1
    return 1 if aplayer == 2
end

def ticboard(board, aplayer, x) #writes X or O to the board
	board[x.to_i - 1] = 'X' if aplayer == 1
	board[x.to_i - 1] = 'O' if aplayer == 2
return board
end

def printboard(board) #prints board
system ("clear")

x = 1
y = 0
    3.times {
        3.times {
            print "#{board[x-1]}"
            print "|" if x % 3 != 0
            x +=1
        }
        puts ""
        puts "-----" if (y < 2)
        y +=1
    }
    puts ""
end

def checkwin(board, aplayer) 
#checks status of game, returns 0 if game is ongoing, 1 for player1, 2 for player2, or 3 if game is a tie
require 'set'
winning = []

board.each.with_index {|i, idx|
    if aplayer == 1
        winning << idx if i == 'X'
    elsif aplayer == 2
        winning << idx if i == 'O' 
    end
}

return 0 if winning.size < 3

#winning combinations
a,b,c,d,e,f,g,h = Set[0,1,2], Set[0,4,8], Set[2,4,6], Set[3,4,5], Set[6,7,8], Set[0,3,6], Set[1,4,7], Set[2,5,8] 

if (a.subset? winning.to_set) || (b.subset? winning.to_set) || (c.subset? winning.to_set) || (d.subset? winning.to_set) || (e.subset? winning.to_set) || (f.subset? winning.to_set) || (g.subset? winning.to_set) || (h.subset? winning.to_set)
    return aplayer
    end

return 3 if board.any? { |k| k.is_a? Fixnum } == false

return 0
end

win = 0
board = [1,2,3,4,5,6,7,8,9] #instantiates board
aplayer = [1,2].sample #randoms X or O starting
printboard(board)

while win == 0 do
	x = player(board, aplayer)
		break if x == 'quit' #quits if user types "quit"
	board = ticboard(board, aplayer,x)
	win = checkwin(board, aplayer)
	aplayer = switchplayer(aplayer)
	printboard(board)
end

puts "X Wins!" if win == 1
puts "O Wins!" if win == 2
puts "Nobody wins, play again" if win == 3
