require File.expand_path(File.dirname(__FILE__) + '/singer')

class Stage
  def initialize(songs, logs)
    @songs_path = songs
    @logs_path = logs
  end

  def play(song)
    singer = Singer.new(self, song)
    singer.sing
    singer
  end

  def listen(song)
    Singer.new(self, song).lyrics
  end

  def song_file(song)
    @songs_path + "/" + song
  end

  def log_file(song)
    @logs_path + "/" + song + ".log"
  end
end