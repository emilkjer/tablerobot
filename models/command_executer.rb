class CommandExecuter
  attr_reader :table_size, :position
  require 'Set'  
  
  def initialize
    #directions: 1 = NORTH, 2 = EAST, 3 = SOUTH, 4 = WEST
    @position = {:x => nil, :y => nil, :direction => nil}
    
    @table_size = {
      :x_min => 0,
      :x_max => 4,
      :y_min => 0,
      :y_max => 4}  
  end
  
  
  def execute_place_command(command)
    #Split on space or comma
    command_array = command.split(/[\s,]+/)
    
    #Test number of commands
    if not command_array.length == 4
      return false
    end     
    
    #Test a numeric input for coordinates
    begin
      x = Integer(command_array[1])
      y = Integer(command_array[2])
    rescue ArgumentError
      return false
    end
    
    #Test valid location
    if not validate_legal_position(x,y)
      return false
    end
    
    #Test if NORTH, EAST, SOUTH or WEST
    direction_options = Set.new ['NORTH', 'EAST', 'SOUTH', 'WEST']
    direction = command_array[3]
    if not direction_options.include? direction
      return false
    end
    
    #Execute update position and direction
    belief_update_position(x, y)
    belief_update_direction(direction)    
  end


  def execute_move_command
    #Ensure the command can be executed
    if not validate_is_on_table then
      return false
    end
    belief_move_forwards
  end
  

  def execute_left_command
    #Ensure the command can be executed
    if not validate_is_on_table then
      return false
    end
    belief_turn_counterclockwise
  end

  
  def execute_right_command
    #Ensure the command can be executed
    if not validate_is_on_table then
      return false
    end
    belief_turn_clockwise
  end


  def execute_report_command
    #Ensure the command can be executed
    if not validate_is_on_table then
      return
    end
    puts 'Output: '+@position[:x].to_s+','+
                    @position[:y].to_s+
                    ','+translate_direction_integer_to_string
  end
  
  
  def belief_move_forwards
    #Ensure :direction has a value
    if @position[:direction].nil? 
      return false
    end
    
    #Dependent on direction move in the correct direction
    x_new = nil
    y_new = nil
    
    #Move NORTH
    if @position[:direction] == 0
      x_new = @position[:x]
      y_new = @position[:y]+1
    #Move EAST
    elsif @position[:direction] == 1
      x_new = @position[:x]+1
      y_new = @position[:y]    
    #Move SOUTH
    elsif @position[:direction] == 2
      x_new = @position[:x]
      y_new = @position[:y]-1
    #Move WEST
    elsif @position[:direction] == 3
      x_new = @position[:x]-1
      y_new = @position[:y]    
    else
      return false
    end
    
    #3. Execute 
    belief_update_position(x_new, y_new)
  end
  
  
  def belief_turn_clockwise
    #Ensure :direction has a value
    if @position[:direction].nil?
      #We could make proper exception here 
      return false
    end
    
    direction_new = @position[:direction]+1
    if direction_new == 4 then
      @position[:direction] = 0
    else
      @position[:direction] = direction_new
    end
  end  

  def belief_turn_counterclockwise
    #Ensure :direction has a value
    if @position[:direction].nil?
      #We could make proper exception here 
      return false
    end
    
    direction_new = @position[:direction]-1
    if direction_new == -1 then
      @position[:direction] = 3
    else
      @position[:direction] = direction_new
    end
  end

  def belief_update_position(x,y)
    if validate_legal_position(x,y) then
      @position[:x] = x
      @position[:y] = y 
    else
      #We could make proper exception here
      return false
    end
  end  
  
  def belief_update_direction(direction_string)
    direction_integer = translate_direction_string_to_integer(direction_string)
    if direction_integer != false
      @position[:direction] = direction_integer
    end
  end
  
  def translate_direction_integer_to_string
    direction_integer = @position[:direction]
    if direction_integer == 0
      return 'NORTH'
    elsif direction_integer == 1
      return 'EAST'
    elsif direction_integer == 2
      return 'SOUTH'
    elsif direction_integer == 3
      return 'WEST'
    else
      return nil
    end
  end
  
  def translate_direction_string_to_integer(direction_string)
    if direction_string == 'NORTH'
      return 0
    elsif direction_string == 'EAST'
      return 1
    elsif direction_string == 'SOUTH'
      return 2
    elsif direction_string == 'WEST'
      return 3
    else
      return false
    end
  end
  
  
  def validate_legal_position(x,y)
    if x >= table_size[:x_min] and 
      x <= table_size[:x_max] and 
      y >= table_size[:y_min] and 
      y <= table_size[:y_max] then
      return true
    else
      return false
    end
  end
   
  def validate_is_on_table
    #Check if the robot is on the table
    if position[:direction] != nil then
      return true
    else
      return false
    end
  end
end