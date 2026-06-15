#! usr/local/bin/ruby
# client1.ruby

require 'socket'

host = 'www.is.kyusan-u.ac.jp'
port = 'http'
path = '/~toshi/'

sock = TCPSocket.new host , port
cmd = 'GET ' + path + " HTTP/1.0\r\n"
pp cmd
sock.puts cmd
sock.puts "\r\n"

while line = sock.gets
  puts line
end