class CommandExecuter
  def initialize
    @position = {:x => nil, :y => nil}
  end
  
  def execute_command(command)
    puts "hello"
    puts @position
  end
end