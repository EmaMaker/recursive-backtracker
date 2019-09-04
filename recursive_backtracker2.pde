//Algorithm from: https://en.wikipedia.org/wiki/Maze_generation_algorithm


int W = 20;
int H = 20;

int w = W*2 + 1, h = H*2 + 1;

float sizeW, sizeH;
float rSizeW, rSizeH;

Cell currentCell;
Cell[][] cellsGrid;
ArrayList<Cell> stack = new ArrayList<Cell>();
int[][] todraw;

void setup(){
  size(800, 800);
  
  sizeW = width/W;
  sizeH = height/H;
  
  
  cellsGrid=new Cell[W][H];
  todraw = new int[w][h];
  
  rSizeW = width / w;
  rSizeH = height / h;
  
  generate();
  
}


void generate(){
  
  //init cells
  for(int i = 0; i < W; i++){
    for(int j = 0; j < H; j++){
      cellsGrid[i][j] = new Cell(i, j);
    }
  }
  
  currentCell = cellsGrid[0][0];
  
  
  //while there are unvisited cells
  while(!allCellsVisited()){
    //mark current as visisted
    currentCell.visited = true;
    
    //check for unvisited neighbours
    Cell[] neighbours = currentCell.unvisitedNeighbours();
    
    //if the cell has unvisited neighbours
    if(neighbours.length > 0){
      //Randomly choose one      
      Cell n = neighbours[(int) random(neighbours.length)];
      
      //Push current cell to the stack
      stack.add(currentCell);
      
      //Delete the walls
      if(n.x == currentCell.x+1){
        //right
        currentCell.walls[1] = false;
        n.walls[3] = false;
      }
      if(n.x == currentCell.x-1){
        //left
        currentCell.walls[3] = false;
        n.walls[1] = false;
      }
      if(n.y == currentCell.y+1){
        //up
        currentCell.walls[2] = false;
        n.walls[0] = false;
      }
      if(n.y == currentCell.y-1){
        //down
        currentCell.walls[0] = false;
        n.walls[2] = false;
      }
      currentCell.current = false;
      currentCell = n;
      currentCell.current = true;
    }else if(!stack.isEmpty()){
      currentCell.current = false;
      //pop a cell from the custom and make it the current one
      currentCell = stack.get(stack.size() -1);
      stack.remove(stack.size() -1);
      currentCell.current = true;
    }
  }
}


void draw(){
  
  //for(int i = 0; i < w; i++){
  //  for(int j = 0; j < h; j++){
  //    todraw[i][j] =(int) random(2);     
  //  }
  //}
  
  //constructs an array so that the walls of the cells are black tiles and the free cells are white tiles
  
  for(int i = 0; i < W; i++){
    for(int j = 0; j < H; j++){
      int x = 2*i+1;
      int y = 2*j+1;
      
      //current cell
      todraw[x][y] = 0;
      
      //questo fa solo una croce attorno alla cella
      //up wall
      
      if(cellsGrid[i][j].walls[0]) todraw[x][y-1] = 1;
      else todraw[x][y-1] = 0;
      //down wall
      if(cellsGrid[i][j].walls[2]) todraw[x][y+1] = 1;
      else todraw[x][y+1] = 0;
      //left wall
      if(cellsGrid[i][j].walls[3]) todraw[x-1][y] = 1;
      else  todraw[x-1][y] = 0;
      //right all
      if(cellsGrid[i][j].walls[1]) todraw[x+1][y] = 1;
      else todraw[x+1][y] = 0;
      
      //così si fanno pure gli angoli
      //top-left
      if(cellsGrid[i][j].walls[0] && cellsGrid[i][j].walls[3])  todraw[x-1][y-1] = 1;
      //top-right
      if(cellsGrid[i][j].walls[0] && cellsGrid[i][j].walls[1])  todraw[x+1][y-1] = 1;
      //bottom-right
      if(cellsGrid[i][j].walls[2] && cellsGrid[i][j].walls[1])  todraw[x+1][y+1] = 1;
      //bottom-left
      if(cellsGrid[i][j].walls[2] && cellsGrid[i][j].walls[3])  todraw[x-1][y+1] = 1;
      
      
    }
  }
  
  
  for(int i = 0; i < w; i++){
    for(int j = 0; j < h; j++){
      fill(255);
      if(todraw[i][j] == 1) fill(0);
      noStroke();
      
      rect(i*rSizeW, j*rSizeH, rSizeW, rSizeH);
        
    }
  }
  
}
/*
void draw(){
  background(0);
  
  
  for(int i = 0; i < W; i++){
    for(int j = 0; j < H; j++){
      cellsGrid[i][j].show();
    }
  }
  
  //frameRate(1);
}*/

boolean allCellsVisited() {
  for(int i = 0; i < W; i++){
    for(int j = 0; j < H; j++){
      if(!cellsGrid[i][j].visited) return false;
    }
  }
  return true;
}
