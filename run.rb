#!/usr/bin/env ruby


require_relative './helpers/file_reader_helper.rb'
require_relative './controllers/commander.rb'
require_relative './models/command_executer.rb'

class TableRobot
  
  
  def initialize
    #TODO naiming convension of global commands
    $command_executer = CommandExecuter.new
    @commander = Commander.new($command_executer)
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
    puts "Usage: ruby run.rb <DATAFILE>"
    puts "E.g. ruby run.rb data/hello_world.dat"
  else
    x = TableRobot.new
    x.run(ARGV.first)
  end
  
end


