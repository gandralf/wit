log = File.new('log/sinatra.log', 'a')
$stdout.reopen(log)
$stderr.reopen(log)

require 'app/web/sing'
run Sinatra::Application
