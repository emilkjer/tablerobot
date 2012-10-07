class Commander
  def initialize(command_executer)
    @command_executer = command_executer  
  end
  
  def read_command(command)
    #TODO refactor this a bit nicer
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
      #TODO doe something to respond here
      puts "ERROR: UNKNOWN COMMAND: " + command
    end  
  end
  
end