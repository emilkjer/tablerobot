class CommandExecuter
  def initialize
    position = {:x => nil, :y => nil, :direction => nil}
    @table_size = {
      :x_min => 0,
      :x_max => 4,
      :y_min => 0,
      :y_max => 4}  
  end
  
  #TODO make error handling verbose
  #TODO input validation for all below
  
  def execute_place_command(command)
    command_array = command.split(/[\s,]+/)
    print command_array
    puts "hello " + command
    puts position
    #TODO exception on input
    belief_update_position(command_array[1].to_i, command_array[2].to_i)
    puts position
  end

  def execute_move_command(command)
    puts "hello " + command
    puts position
  end
  
  def execute_left_command(command)
    puts "hello " + command
    puts position
  end
  
  def execute_right_command(command)
    puts "hello " + command
    puts position
  end
  
  def execute_report_command(command)
    puts "hello " + command
    puts position
  end
  
  
  def belief_move_to_new_position
    #TODO validate if position is legal
      
  end

  def belief_update_position(x,y)
    if validate_legal_position(x,y) then
      position[:x] = x
      position[:y] = y 
    else
      #TODO make proper exception here 
      puts "ERROR: Illigal move"
      return false
    end
  end  
  
  def validate_legal_position(x,y)
    if x >= @table_size[:x_min] and x <= @table_size[:x_max] then
      return true
    else
      return false
    end
  end
   
end