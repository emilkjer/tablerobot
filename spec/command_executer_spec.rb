require 'spec_helper'

describe CommandExecuter do
  before :each do
    @command_executer = CommandExecuter.new
  end
  
  describe "#initialize" do
    it "has a position" do
      @command_executer.position[:x].should eql nil
    end
    
    it "has a table size" do
      @command_executer.table_size.should_not eql nil
      # @command_executer.table_size[:x_min].should eql 0
    end
  end
  
  describe "#execute_place_command" do
    it "is legal to input PLACE 0,0,NORTH" do
      @command_executer.execute_place_command('PLACE 0,0,NORTH')
      @command_executer.position.should include(:x => 0, :y => 0,:direction => 0)
    end
    
    it "is NOT legal to input PLACE 0,-1,NORTH" do
      @command_executer.execute_place_command('PLACE 0,-1,NORTH')
      @command_executer.position.should include(:x => nil, :y => nil,:direction => nil)
    end
    
    it "is NOT legal to input PLACE a,b,NORTH" do
      @command_executer.execute_place_command('PLACE a,b,NORTH')
      @command_executer.position.should include(:x => nil, :y => nil,:direction => nil)
    end
    
    it "is NOT legal to input PLACE 0,0" do
      @command_executer.execute_place_command('PLACE 0,0')
      @command_executer.position.should include(:x => nil, :y => nil,:direction => nil)
    end
    
    it "is NOT legal to input PLACE NORTH" do
      @command_executer.execute_place_command('PLACE NORTH')
      @command_executer.position.should include(:x => nil, :y => nil,:direction => nil)
    end
  end
  
  describe "#validate_legal_position" do
    it "is legal to position (0,0) edge min" do
      x = 0
      y = 0
      @command_executer.belief_update_position(x,y)
      @command_executer.position.should include(:x => x, :y => y)
    end

    it "is legal to position (4,4) edge max" do
      x = 4
      y = 4
      @command_executer.belief_update_position(x,y)
      @command_executer.position.should include(:x => x, :y => y)
    end
    
    it "is NOT legal to position (5,5) edge more than max" do
      x = 5
      y = 5
      x_before = @command_executer.position[:x]
      y_before = @command_executer.position[:y]
      @command_executer.belief_update_position(x,y)
      @command_executer.position[:x].should_not eql x
      @command_executer.position[:y].should_not eql y
      @command_executer.position[:x].should eql x_before
      @command_executer.position[:y].should eql y_before
    end

    it "is NOT legal to position (-1,-1) edge less than min" do
      x = -1
      y = -1
      x_before = @command_executer.position[:x]
      y_before = @command_executer.position[:y]
      @command_executer.belief_update_position(x,y)
      @command_executer.position[:x].should_not eql x
      @command_executer.position[:y].should_not eql y
      @command_executer.position[:x].should eql x_before
      @command_executer.position[:y].should eql y_before
    end


    it "is NOT legal to position (0,-1) edge less than min y" do
      x = 0
      y = -1
      x_before = @command_executer.position[:x]
      y_before = @command_executer.position[:y]
      @command_executer.belief_update_position(x,y)
      @command_executer.position[:x].should_not eql x
      @command_executer.position[:y].should_not eql y
      @command_executer.position[:x].should eql x_before
      @command_executer.position[:y].should eql y_before
    end


    it "is NOT legal to position (-1,0) edge less than min x" do
      x = -1
      y = 0
      x_before = @command_executer.position[:x]
      y_before = @command_executer.position[:y]
      @command_executer.belief_update_position(x,y)
      @command_executer.position[:x].should_not eql x
      @command_executer.position[:y].should_not eql y
      @command_executer.position[:x].should eql x_before
      @command_executer.position[:y].should eql y_before
    end
  end 
  
  
  describe "#belief_turn_clockwise" do
    it "is possible to turn clockwise NORTH -> EAST ON table" do
      @command_executer.position[:direction] = 0
      @command_executer.belief_turn_clockwise
      @command_executer.position[:direction].should eql 1
    end
  
    it "is possible to turn clockwise WEST -> NORTH ON table" do
      @command_executer.position[:direction] = 3
      @command_executer.belief_turn_clockwise
      @command_executer.position[:direction].should eql 0
    end
  end
  
  describe "#belief_turn_counterclockwise" do
    it "is possible to turn clockwise NORTH -> WEST ON table" do
      @command_executer.position[:direction] = 0
      @command_executer.belief_turn_counterclockwise
      @command_executer.position[:direction].should eql 3
    end
  
    it "is possible to turn clockwise EAST -> NORTH ON table" do
      @command_executer.position[:direction] = 1
      @command_executer.belief_turn_counterclockwise
      @command_executer.position[:direction].should eql 0
    end
  end  
  
  describe "#validate_is_on_table" do
    it "is on the table" do
      @command_executer.position[:direction] = 0
      @command_executer.position[:x] = 0
      @command_executer.position[:y] = 0
      @command_executer.validate_is_on_table.should be true
    end
    
    it "is NOT on the table" do
      @command_executer.position[:direction] = nil
      @command_executer.position[:x] = nil
      @command_executer.position[:y] = nil
      @command_executer.validate_is_on_table.should_not be true
    end
    
    it "is initially NOT be on the table" do
      @command_executer.validate_is_on_table.should_not be true
    end
  end

  describe "#belief_move_forwards" do
    it "move NORTH from (0,0)" do
      x = 0
      y = 0
      @command_executer.position[:direction] = 0
      @command_executer.position[:x] = x
      @command_executer.position[:y] = y
      @command_executer.belief_move_forwards
      @command_executer.position.should include(:x => x, :y => y+1)
    end
    it "move SOUTH from (4,4)" do
      x = 4
      y = 4
      @command_executer.position[:direction] = 2
      @command_executer.position[:x] = x
      @command_executer.position[:y] = y
      @command_executer.belief_move_forwards
      @command_executer.position.should include(:x => x, :y => y-1)
    end
    it "move EAST from (2,2)" do
      x = 2
      y = 2
      @command_executer.position[:direction] = 1
      @command_executer.position[:x] = x
      @command_executer.position[:y] = y
      @command_executer.belief_move_forwards
      @command_executer.position.should include(:x => x+1, :y => y)
    end
    
    
    it "does NOT move NORTH from (0,4)" do
      x = 0
      y = 4
      @command_executer.position[:direction] = 0
      @command_executer.position[:x] = x
      @command_executer.position[:y] = y
      @command_executer.belief_move_forwards
      @command_executer.position.should include(:x => x, :y => y)
    end
    it "does NOT move SOUTH from (0,0)" do
      x = 0
      y = 0
      @command_executer.position[:direction] = 2
      @command_executer.position[:x] = x
      @command_executer.position[:y] = y
      @command_executer.belief_move_forwards
      @command_executer.position.should include(:x => x, :y => y)
    end
    it "does NOT move WEST from (0,0)" do
      x = 0
      y = 0
      @command_executer.position[:direction] = 3
      @command_executer.position[:x] = x
      @command_executer.position[:y] = y
      @command_executer.belief_move_forwards
      @command_executer.position.should include(:x => x, :y => y)
    end
    

  end

end