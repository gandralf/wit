require 'sinatra'
require 'haml'

get '/favicon.ico' do
  [404, nil, '']
end

get '/:song' do |song|
  @song = song
  @output = `$HOME/.wit/#{song}` if song && song.match("^[\\w_\\-]+$")
  haml $?.success? ? :success : :fail
end

__END__

@@ layout
%html
  = yield
  %div
    Command: 
    %pre #{@song}
  %h2 Output
  %pre #{@output}
  Done.

@@ success
%h1 Aplause!

@@ fail
%h1 Buuuuu!
