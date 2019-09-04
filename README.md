Recursive Backtracker

In this repository there are various implementations of the Recursive Backtracker Maze Generation algorithm, explained at https://en.wikipedia.org/wiki/Maze_generation_algorithm#Recursive_backtracker

The branches:
master: Maze generation and animation of the algorithm done in Processing.
recursive-backtracker-cells: Same as master branch, but there's no animation. Also the walls are not lines anymore but they're considered like cells. There's a red rectangle that can be moved around the maze with the arrow keys. Used as a starting point for the C Console implementation
c-implementation: C Implementation of the algorithm, based on the recursive-backtracker-cells branch. The program generates a 30x30 maze that is printed in the console when executed.
