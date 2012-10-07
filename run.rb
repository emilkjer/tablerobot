#!/usr/bin/env ruby

require_relative './helpers/file_reader_helper.rb'
require_relative './controllers/commander.rb'
require_relative './models/command_executer.rb'

class TableRobot
  
  
  def initialize
    @command_executer = CommandExecuter.new
    @commander = Commander.new(@command_executer)
  end
  
  def run(file_name)
    @file_reader = FileReader.new
    file_content = @file_reader.read_file_as_array(file_name)
    if file_content 
      execute_commands(file_content)
    else
      display_usage
    end
  end
  
  def execute_commands(commands)
    commands.each do |command|
      execute_command(command)
    end
    
  end
  
  def execute_command(command)
    @commander.read_command(command)    
  end
  
  def display_usage
    puts "Usage: ruby run.rb <DATAFILE>"
    puts "E.g. ruby run.rb data/hello_world.dat"
  end
  
end


if __FILE__ == $0
  #TODO some verification of the input argument should be performed here
  #TODO improvement: fetch input --filename param
  
  x = TableRobot.new
  
  if ARGV.length <0 then
    #TODO write run command guide
    x.display_usage
  else
    
    x.run(ARGV.first)
  end
  
end


