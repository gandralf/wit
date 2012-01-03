class Singer
  attr_reader :public_reaction

  def initialize(stage, song)
    if !song || !song.match("^[\\w_\\-]+$")
      raise "Can't sing #{song}"
    end
    @stage = stage
    @song = song
  end

  def sing
    `#{@stage.song_file(@song)} &> #{@stage.log_file(@song)}`
    @public_reaction = $?.success? ? :success : :fail
  end

  def lyrics
    result = nil
    file = File.new(@stage.log_file(@song), "r")
    if (file)
      result = ""
      while (line = file.gets)
        result += "#{line}"
      end
      file.close
    end
    result
  end
end