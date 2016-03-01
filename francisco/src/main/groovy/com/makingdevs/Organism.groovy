package com.makingdevs
class Organism{
  def cells=[]
  def new_state=[]
  Organism(){
    cells = [[0,0,0],[0,1,0],[1,0,1]]
    new_state = [[0,0,0],[0,1,0],[1,0,1]]
  }

  def populate(cells){
    cells = this.cells
  }

  def evolve(){
    cells.eachWithIndex{ row, index->
      row.eachWithIndex{ element, indx->
        //println "evolve:---"+element
      }
    }
  }
   
  def reassign(){
    new_state.eachWithIndex{row,x->
      new_state.eachWithIndex{element,j->
        cells[x][j] = element
      }
    }
  }
    
  
  def coordinates(x, y){
    [[x - 1, y - 1], [x - 1, y], [x - 1, y + 1],
     [x, y - 1],                 [x, y + 1],
     [x + 1, y - 1], [x + 1, y], [x + 1, y + 1]]
  }

  def find_neighbors(x, y){
    def coordinates_for_neighbors = coordinates(x, y)
    def matrix = cells
    //println "Matriz "+matrix
    def neighbors = []
    for(int fila=0;fila<matrix.size;fila++){
      for(int col=0;col<matrix.size;col++){
          if(x!=fila || y!=col){
            neighbors << matrix[fila][col]
          }
      }
    }
    neighbors
  }

  def might_die_because_has_fewer_than_two_neighbours( neighbors){
    neighbors.count(1) < 2
  }
  
  def might_live_because_has_two_or_three_neighbours( neighbors){
    (neighbors.count(1) >= 2 && neighbors.count(1) <= 3)
  }

  def might_die_because_has_more_than_tree_neighbours(neighbors){
    neighbors.count(1) > 3
  }

  def might_reborn_because_has_exactly_three_neighbours( neighbors){
    (neighbors.count(1)==3)
  }

  def next_state(){
    def matrix = cells
    
    for(int fila=0;fila<matrix.size;fila++){
      for(int col=0;col<matrix.size;col++){
        def neighbors = find_neighbors(fila,col)
        switch(matrix[fila][col]) {
          case 0:
            if(might_die_because_has_fewer_than_two_neighbours( neighbors) || might_die_because_has_more_than_tree_neighbours( neighbors)){
              new_state[fila][col] = 0 
            }

            else if(might_live_because_has_two_or_three_neighbours( neighbors)){
              new_state[fila][col] = 1 
            }
          break
          case 1:
            new_state[fila][col] = might_reborn_because_has_exactly_three_neighbours(neighbors) ? 1 : 0
          break
        }
      }
    }
    println "last next-state: "+new_state
    new_state
  }

  static void main(args){
    Organism organismo=new Organism()
    for (int iterar=0;iterar<3;iterar++){
      System.out.println ("\f")
      organismo.evolve()
      organismo.next_state()
      organismo.reassign()
      sleep(1000)
    }
  }
    
}