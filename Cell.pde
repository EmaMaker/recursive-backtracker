public class Cell{
  
  public boolean visited=false;
  public boolean current=false;
  public boolean[] walls = {true, true, true, true};
  
  //top, right, bottom, left,
  //true means wall present
  
  int x, y;
  
  public Cell(int x_, int y_){
    this.x = x_;
    this.y = y_;
  }
  
  void show(){
    int i = x*(int)sizeW;
    int j = y*(int)sizeH;
    
    noStroke();
    if(visited) fill(255, 0, 0);
    if(current) fill(0, 0, 255);
    if(visited||current) rect(i, j, sizeW, sizeH);
    
    stroke(255);
    
    
    if(walls[0]) line(i, j, i+sizeW, j);
    if(walls[1]) line(i+sizeW, j, i+sizeW, j+sizeH);
    if(walls[2]) line(i, j+sizeH, i+sizeW, j + sizeH);
    if(walls[3]) line(i, j, i, j+sizeH);
  }
  
  //returning an array of unvisited neighbours, so that they can be easily choosed later on
  Cell[] unvisitedNeighbours(){
    int un = 0;
    if(x-1 >= 0 && !cellsGrid[x-1][y].visited) un++;
    if(x+1 < W && !cellsGrid[x+1][y].visited) un++;
    if(y-1 >= 0 && !cellsGrid[x][y-1].visited) un++;
    if(y+1 < H && !cellsGrid[x][y+1].visited) un++;
    
    Cell[] c = new Cell[un];
    
    int tun = 0;
    if(x-1 >= 0 && !cellsGrid[x-1][y].visited){
      c[tun] = cellsGrid[x-1][y];
      tun++;
    }
    if(x+1 < W && !cellsGrid[x+1][y].visited){
      c[tun] = cellsGrid[x+1][y];
      tun++;
    }
    if(y-1 >= 0 && !cellsGrid[x][y-1].visited){
      c[tun] = cellsGrid[x][y-1];
      tun++;
    }
    if(y+1 < H && !cellsGrid[x][y+1].visited) {
      c[tun] = cellsGrid[x][y+1];
      tun++;
    }
    return c;
  }
  
}
