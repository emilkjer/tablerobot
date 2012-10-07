=begin
  * Name: Toy Robot Simulator 
  * Description: 
  *   Read data file. 
  *   Commands are separated by newline separator.
  * @Author: Emil Kjer
  * Date: 9/10/2012
=end

class FileReader
  def read_file(file_name)
    #Simple file read
    begin 
      file_content = IO.read(file_name)
      return file_content
    rescue => err
      puts "Exception: #{err}"
      return err
    end
  end
  
  def read_file_as_array(file_name)
    #Split commands by newline and return an array with the commands
    begin
      file_content = read_file(file_name)
      result = file_content.split(/[\n]+/)
      return result
    rescue
      return false
    end
  end
end