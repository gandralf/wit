class Stage
  def initialize(song)
    if !song || !song.match("^[\\w_\\-]+$")
      raise "Can't sing #{song}"
    end
    @song = song
  end

  def sing
    `$HOME/.wit/#{@song} &> #{log_file_name}`
    $?.success?
  end

  def lyrics
    result = nil
    file = File.new(log_file_name, "r")
    if (file)
      result = ""
      while (line = file.gets)
        result += "#{line}"
      end
      file.close
    end
    result
  end

  private
  def log_file_name()
    File.expand_path(File.dirname(__FILE__) + "/../../log/#{@song}.log")
  end
end