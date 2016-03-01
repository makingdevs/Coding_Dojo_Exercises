package com.makingdevs

import spock.lang.Specification 

class OrganismSpec extends Specification{
  private Organism organism
  def setup(){
    organism=new Organism()
  }
  
  def "given the coordinate with [1, 1], should get around set coordinates"(){
    given:
      Integer x=1
      Integer y=1
    when:
      def coordinates = organism.coordinates(x,y)
    then:
      coordinates==[[0, 0], [0, 1], [0, 2], [1, 0], [1, 2], [2, 0], [2, 1], [2, 2]]
  }
  
  def "given a cell in position [1,1] should return 8 neighbors"(){
    given:
      Integer x=1
      Integer y=1
    when:
      def neighbors = organism.find_neighbors(x,y)
    then:
      neighbors==[0,0,0,0,0,1,0,1]
  }

  def "given a cell in position [0,1] should return 8 neighbors"(){
    given:
      Integer x=0
      Integer y=1
    when:
      def neighbors = organism.find_neighbors(x,y)
    then:
      neighbors==[0,0,0,1,0,1,0,1]
  }

  def "given a cell in position [0,2] should return 8 neighbors"(){
    given:
      Integer x=0
      Integer y=2
    when:
      def neighbors = organism.find_neighbors(x,y)
    then:
      neighbors==[0,0,0,1,0,1,0,1]
  }

  def "given a cell in position [1,0] should return 8 neighbors"(){
    given:
      Integer x=1
      Integer y=0
    when:
      def neighbors = organism.find_neighbors(x,y)
    then:
      neighbors==[0,0,0,1,0,1,0,1]
  }

  def "given a cell in position [2,2] should return 8 neighbors"(){
    given:
      Integer x=2
      Integer y=2
    when:
      def neighbors = organism.find_neighbors(x,y)
    then:
      neighbors==[0,0,0,0,1,0,1,0]
  }

  def "given a neighborhood for a livin cell with fewer than two live neighbors, should die in the next generation" (){
    given:
      def neighborhood = [0,0,0,0,1]
      def living_cell = 1
    when:
      def rule1=organism.might_die_because_has_fewer_than_two_neighbours( neighborhood)
    then:
      rule1==true
  }

  def "given a neighborhood for a livin cell with no more than 2 or 3 live neighbors should live in the next generation" (){
    given:
      def neighborhood = [1,1,0,0,0]
      def living_cell = 1
    when:
      def rule2=organism.might_live_because_has_two_or_three_neighbours( neighborhood)
    then:
      rule2==true
  }

  def "given a neighborhood for a live cel with more than 3 live neighbors, should die in the next generation" (){
    given:
      def neighborhood = [1,1,1,1,0,0]
      def living_cell = 1
    when:
      def rule3=organism.might_die_because_has_more_than_tree_neighbours(neighborhood)
    then:
      rule3==true
  }

  def "given a neighborhood and a dead cell with three neighbors lives, should live in the next generation" (){
    given:
      def neighborhood = [1,1,1,0,0]
      def died_cell=0
    when:
      def rule4=organism.might_reborn_because_has_exactly_three_neighbours(neighborhood)
    then:
      rule4==true
  }
  
  def "given an organism [[0,0,0],[0,1,0],[1,0,1]], after the rules applied the next state should be [[1,1,1],[1,0,1],[0,1,0]]" (){
    given:
      
    when:
      def cells = organism.next_state()
    then:
      cells==[[1,1,1],[1,0,1],[0,1,0]]
  }

}