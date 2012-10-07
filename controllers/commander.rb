class Commander
  def initialize(command_executer)
    $command_executer = command_executer  
  end
  
  def read_command(command)
    #TODO refactor this a bit nicer
    command_clean = command.split(' ')
    control = command_clean[0].upcase
    
    #We have a limited numer of options so a switch is used 
    case  control
    when "PLACE"
      puts "PLACE: " + command
      $command_executer.execute_place_command(command)
    when "MOVE"
      puts "MOVE: " + command
      $command_executer.execute_move_command(command)
    when "LEFT"
      puts "LEFT: " + command
      $command_executer.execute_left_command(command)
    when "RIGHT"
      puts "RIGHT: " + command
      $command_executer.execute_right_command(command)
    when "REPORT"
      puts "REPORT: " + command
      $command_executer.execute_report_command(command)
    else
      #TODO doe something to respond here
      puts "UNKNOWN: " + command
    end  
  end
  
end