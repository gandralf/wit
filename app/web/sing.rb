require 'sinatra'
require 'haml'
require File.expand_path(File.dirname(__FILE__) + "/../model/stage")

set :root, File.expand_path(File.dirname(__FILE__) + "/../../")

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
  begin
    stage = Stage.new(song)
    public_reaction = stage.sing
    @output = stage.lyrics
  rescue
    public_reaction = :fail
    @output = "Can' sing this song: #{song}"
  end
  haml public_reaction
end

get_or_post '/:song/log' do |song|
  begin
    stage = Stage.new(song)
    @output = stage.lyrics
    public_reaction = :success
  rescue
    public_reaction = :fail
    @output = "Can't load #{song}'s lyrics"
  end

  haml public_reaction
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
