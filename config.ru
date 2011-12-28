log = File.new('log/sinatra.log', 'a')
$stdout.reopen(log)
$stderr.reopen(log)

require 'sing.rb'
run Sinatra::Application
