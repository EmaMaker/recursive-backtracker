//Algorithm from: https://en.wikipedia.org/wiki/Maze_generation_algorithm


int W = 40;
int H = 40;

float sizeW, sizeH;

Cell[][] cellsGrid;
ArrayList<Cell> stack = new ArrayList<Cell>();
Cell currentCell;

void setup(){
  size(800, 800);
  
  sizeW = width/W;
  sizeH = height/H;
  
  
  cellsGrid=new Cell[W][H];
  
  
  //init cells
  for(int i = 0; i < W; i++){
    for(int j = 0; j < H; j++){
      cellsGrid[i][j] = new Cell(i, j);
    }
  }
  
  currentCell = cellsGrid[0][0];
  
}




void draw(){
  background(0);
  
  //while there are unvisited cells
  if(!allCellsVisited()){
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
  
  for(int i = 0; i < W; i++){
    for(int j = 0; j < H; j++){
      cellsGrid[i][j].show();
    }
  }
  
  //frameRate(1);
}

boolean allCellsVisited() {
  for(int i = 0; i < W; i++){
    for(int j = 0; j < H; j++){
      if(!cellsGrid[i][j].visited) return false;
    }
  }
  return true;
}




/*void draw(){
  
  for(int i = 0; i < w; i++){
    for(int j = 0; j < h; j++){
      todraw[i][j] = 0;     
    }
  }
  
  
  for(int i = 0; i < w; i++){
    for(int j = 0; j < h; j++){
      fill(255);
      if(todraw[i][j] == 1) fill(0);
      println(todraw[i][j]);
      noStroke();
      
      rect(i*rSizeW, j*rSizeH, rSizeW, rSizeH);
        
    }
  }
  
  noLoop();
}*/
