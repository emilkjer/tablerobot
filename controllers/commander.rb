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
      puts "PLACE: " + command
      @command_executer.execute_command(command)
    when "MOVE"
      puts "MOVE: " + command
    when "LEFT"
      puts "LEFT: " + command
    when "RIGHT"
      puts "RIGHT: " + command
    when "REPORT"
      puts "REPORT: " + command
    else
      puts "UNKNOWN: " + command
    end  
  end
  
end