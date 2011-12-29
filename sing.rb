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
  @song = song
  if song && song.match("^[\\w_\\-]+$")
    @output = `$HOME/.wit/#{song} &> log/#{song}.log && cat log/#{song}.log`
    haml $?.success? ? :success : :fail
  else
    @output = "Invalid integration script: #{song}"
    haml :fail
  end
end

get_or_post '/:song/log' do |song|
  @song = song
  @output = ""
  file = File.new("log/#{song}.log", "r")
  while (line = file.gets)
    @output += "#{line}"
  end
  file.close
  haml file ? :success : :fail
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
