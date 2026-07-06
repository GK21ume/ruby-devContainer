#! /usr/local/bin/ruby
# server1.rb

require 'socket'

def server s
  cmd , path , ver = s.gets.split
  if path == "/"
    pp "index"
    s.puts "index"
  else
    pp "other"
    s.puts "other"
  end
  s.close
end

gs = TCPServer.open 'http'

loop do

  pp "start accept"
  s = gs.accept

  Thread.new do
    server s
    sleep 10
  end

end