#!/usr/bin/env ruby
=begin
  * Name: Toy Robot Simulator 
  * Description: Main run class to run with data form file.
  * @Author: Emil Kjer
  * Date: 8/10/2012
=end

require_relative './helpers/file_reader_helper.rb'
require_relative './controllers/commander.rb'
require_relative './models/command_executer.rb'

class TableRobot
  def initialize
    @command_executer = CommandExecuter.new
    @commander = Commander.new(@command_executer)
  end
  
  
  def run(file_name)
    #Read the commands to the robot from a file and execute them all
    @file_reader = FileReader.new
    file_content = @file_reader.read_file_as_array(file_name)
    if file_content 
      execute_commands(file_content)
    else
      display_usage
    end
  end
  
  #Execute each command in consecutive order
  def execute_commands(commands)
    commands.each do |command|
      execute_command(command)
    end
    
  end
  
  
  def execute_command(command)
    #Let the controller execute the command
    @commander.read_command(command)    
  end
  
  def display_usage
    puts "Usage: ruby run.rb <DATAFILE>"
    puts "E.g. ruby run.rb data/hello_world.dat"
  end
  
end


if __FILE__ == $0
  x = TableRobot.new
  
  if ARGV.length <0 then
    x.display_usage
  else
    x.run(ARGV.first)
  end
  
end


