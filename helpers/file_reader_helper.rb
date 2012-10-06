class FileReader

  def read_file(file_name)
    begin 
      file_content = IO.read(file_name)
      return file_content
    rescue => err
      puts "Exception: #{err}"
      err
    end
  end
  
  def read_file_as_array(file_name)
    file_content = read_file(file_name)
    result = file_content.split(/[\n]+/)
    return result
  end

end