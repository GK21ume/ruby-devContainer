#! usr/local/bin/ruby
# client1.ruby

require 'socket'

host = 'www.is.kyusan-u.ac.jp'
port = 'http'
path = '/~toshi/'

sock = TCPSocket.new host , port
cmd = 'GET ' + path + "\r\n"
pp cmd
sock.puts cmd

while line = sock.gets
  puts line
end