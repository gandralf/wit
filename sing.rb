require 'sinatra'
require 'haml'

def get_or_post(path, opts={}, &block)
  get(path, opts, &block)
  post(path, opts, &block)
end

get '/favicon.ico' do
  [404, nil, '']
end

get_or_post '/:song' do |song|
  @song = song
  @output = `$HOME/.wit/#{song}` if song && song.match("^[\\w_\\-]+$")
  haml $?.success? ? :success : :fail
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
