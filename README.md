# Connect_4

This is my implementation of the Connect-4 board game using functional programing with scheme. 

There are three functions we will work with – startgame, markmove and makemove. Startgame initializes the gameboard, which is in fact the only variable in this entire program: a data structure that holds the state of the board. The rest of the program is purely functional. 
Markmove takes an argument which is the number of the column the player wishes to drop their colored piece into. 
Makemove is a function that makes the system choose a move according to a dynamic strategy that I programmed. 
First it considers all of its legal moves, then it sees if it can make a move to cause it to win. If this is 
not possible, it decides among those legal moves whether there exists a move such that it can block the opposing 
player from winning by simulating the next turn of the game for every possible outcome. If it cannot block, then 
it looks to build upon a chain that it is already creating. For example, if there is a stack of 2, it will add 
to it to make three. If none of this is possible. It picks a random column. 
The game can be played player vs player or computer versus player or even computer versus computer. With every move,
it alternates between red and  black. As you can see, after each move, the game board is updated and displayed. 
The computer checks with every move to see if a winner exists and outputs whether there is or isn’t one until a 
player wins or there are no more legal moves to be made.

If you have any questions please email them to jwweber@asu.edu
