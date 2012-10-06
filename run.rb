#!/usr/bin/env ruby


require './helpers/file_reader_helper.rb'
require './controllers/commander.rb'
require './models/command_executer.rb'

class TableRobot
  
  
  def initialize
    @command_executer = CommandExecuter.new
    @commander = Commander.new(@command_executer)
  end
  
  def run(file_name)
    @file_reader = FileReader.new
    file_content = @file_reader.read_file_as_array(file_name)
    execute_commands(file_content)
  end
  
  def execute_commands(commands)
    commands.each do |command|
      execute_command(command)
    end
    
  end
  
  def execute_command(command)
    @commander.read_command(command)    
  end
  
end


if __FILE__ == $0
  #TODO some verification of the input argument should be performed here
  #TODO improvement: fetch input --filename param
  if ARGV.length <0 then
    #TODO write run command guide
    puts "ruby run.rb data/hello_world.dat"
  else
    x = TableRobot.new
    x.run(ARGV.first)
  end
  
end


