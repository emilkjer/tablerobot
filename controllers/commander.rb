=begin
  * Name: Toy Robot Simulator 
  * Description: Control class for movements
  * @Author: Emil Kjer
  * Date: 9/10/2012
=end

class Commander
  def initialize(command_executer)
    @command_executer = command_executer  
  end
  
  def read_command(command)
    #Split command and get control parameter 
    command_clean = command.split(' ')
    control = command_clean[0].upcase
    
    #We have a limited numer of options so a switch is used 
    case  control
    when "PLACE"
      @command_executer.execute_place_command(command)
    when "MOVE"
      @command_executer.execute_move_command
    when "LEFT"
      @command_executer.execute_left_command
    when "RIGHT"
      @command_executer.execute_right_command
    when "REPORT"
      @command_executer.execute_report_command
    else
      puts "ERROR: UNKNOWN COMMAND: " + command
    end  
  end
end