#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <math.h>
#include <time.h>

typedef struct cell{
    bool visited;
    bool up, down, right, left;
    int x, y;
} cell;

#define W_GRID 15
#define H_GRID 15
#define w_GRID W_GRID*2 +1
#define h_GRID W_GRID*2 +1

cell* current;
cell* grid[W_GRID][H_GRID];

int stackX[W_GRID*H_GRID];
int stackY[W_GRID*H_GRID];
int cv = 0;

int todraw[w_GRID][h_GRID];

void show();
void push();
void pop();
int getX();
int getY();
bool allCellVisited();

int main(){
    //Init random
    srand(time(NULL));

    for(int i = 0; i < W_GRID; i++){
        for(int j = 0; j < H_GRID; j++){
            cell* c = malloc(sizeof(cell));   
            c->visited=false;
            c->up=true;
            c->down=true;
            c->right=true;
            c->left=true;
            c->x = i;
            c->y = j;

            grid[i][j] = c;
        }
    }

    //Pick a current cell
    current = grid[0][0];

    //while there are unvisited cells. This is gonna change when adding a stack
    while(!allCellVisited()){
        current->visited=true;

        //Get unvisited neighbours
        int un = 0;
        int x = current->x;
        int y = current->y;
        if(x-1 >= 0 && !grid[x-1][y]->visited) un++;
        if(x+1 < W_GRID && !grid[x+1][y]->visited) un++;
        if(y-1 >= 0 && !grid[x][y-1]->visited) un++;
        if(y+1 < H_GRID && !grid[x][y+1]->visited) un++;
        
        //If there are any
        if(un > 0){
            int xs[un], ys[un];
            
            int tun = 0;
            if(x-1 >= 0 && !grid[x-1][y]->visited){
                xs[tun] = x-1;
                ys[tun] = y;
                tun++;
            }
            if(x+1 < W_GRID && !grid[x+1][y]->visited){
                xs[tun] = x+1;
                ys[tun] = y;
                tun++;
            }
            if(y-1 >= 0 && !grid[x][y-1]->visited){
                xs[tun] = x;
                ys[tun] = y-1;
                tun++;
            }
            if(y+1 < H_GRID && !grid[x][y+1]->visited) {
                xs[tun] = x;
                ys[tun] = y+1;
                tun++;
            }

            //Randomly choose one
            int c = (int)(rand()) % un;

            //Delete walls
            //Right
            if(grid[xs[c]][ys[c]]->x == current->x+1){
                current->right=false;
                grid[xs[c]][ys[c]]->left=false;
            }
            //Left
            if(grid[xs[c]][ys[c]]->x == current->x-1){
                current->left=false;
                grid[xs[c]][ys[c]]->right=false;
            }
            //Up
            if(grid[xs[c]][ys[c]]->y == current->y-1){
                current->up=false;
                grid[xs[c]][ys[c]]->down=false;
            }
            //Up
            if(grid[xs[c]][ys[c]]->y == current->y+1){
                current->down=false;
                grid[xs[c]][ys[c]]->up=false;
            }

            //Push current cell to the stack
            push(current->x, current->y);

            current = grid[xs[c]][ys[c]];
        }else if(cv > 0){
            //Else if stack is not empty
            current = grid[getX()][getY()];
            pop();
        }
    }


    show();
}

void show(){
  for(int i = 0; i < w_GRID; i++){
    for(int j = 0; j < h_GRID; j++){
      todraw[i][j] = 1;
    }
  }
  
  for(int i = 0; i < W_GRID; i++){
    for(int j = 0; j < H_GRID; j++){
      
      int x = 2*i+1;
      int y = 2*j+1;
      
      //current cell
      todraw[x][y] = 0;
      if(!grid[i][j]->up)todraw[x][y-1]=0;
      if(!grid[i][j]->right)todraw[x+1][y]=0;
      if(!grid[i][j]->down)todraw[x][y+1]=0;
      if(!grid[i][j]->left)todraw[x-1][y]=0;
    }
  }

  for(int j = 0; j < h_GRID; j++){
    for(int i = 0; i < w_GRID; i++){
        if(todraw[i][j] == 1){
            printf("#");
        }else{
            printf(" ");
        }
    }
    printf("\n");
  }
}

bool allCellVisited() {
  for(int i = 0; i < W_GRID; i++){
    for(int j = 0; j < H_GRID; j++){
      if(!grid[i][j]->visited) return false;
    }
  }
  return true;
}


/*STUCK STUFF*/
//Pushes to stackX and stackY
void push(int x, int y){
    if(cv < W_GRID*H_GRID && cv >= 0){
        stackX[cv] = x;
        stackY[cv] = y;
        cv++;
    }
}

void pop(){
    if(cv >= 0){
        cv--;
        stackX[cv] = -1;
        stackY[cv] = -1;
    }
}

int getX(){
    return stackX[cv-1];
}

int getY(){
    return stackY[cv-1];
}
