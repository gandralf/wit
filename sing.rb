require 'sinatra'
require 'haml'

def get_or_post(path, opts={}, &block)
  get(path, opts, &block)
  post(path, opts, &block)
end

get '/favicon.ico' do
  [404, nil, '']
end

get_or_post '/' do
  @output = "Who is gonna sing?"
  haml :success
end

get_or_post '/:song' do |song|
  if song && song.match("^[\\w_\\-]+$")
    `$HOME/.wit/#{song} &> #{log_file_name(song)}`
    success = $?.success?
    @output = log_content(song)
    haml success ? :success : :fail
  else
    @output = "Invalid integration script: #{song}"
    haml :fail
  end
end

def log_file_name(song)
    File.expand_path(File.dirname(__FILE__) + "/log/#{song}.log")
end

def log_content(song)
  result = nil
  file = File.new(log_file_name(song), "r")
  if (file)
    result = ""
    while (line = file.gets)
      result += "#{line}"
    end
    file.close
  end
  result
end

get_or_post '/:song/log' do |song|
  @output = log_content(song) || "Can' load #{song}'s log"
  haml @output ? :success : :fail
end

__END__

@@ layout
%html
  = yield
  %pre #{@output}
  Done.

@@ success
%img{:src => "/img/fuckyea.png"}

@@ fail
%img{:src => "/img/fffuuu.png"}
