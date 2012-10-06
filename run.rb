#!/usr/bin/env ruby


require './helpers/file_reader_helper.rb'

class TableRobot
  
  def run(file_name)
    @file_reader = FileReader.new
    file_content = @file_reader.read_file_as_array(file_name)
    
    puts file_content
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


