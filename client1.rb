#! /usr/local/bin/ruby
# client1.ruby

require 'socket'

host = 'www.is.kyusan-u.ac.jp'
port = 'http'
path = '/~toshi/'

sock = TCPSocket.new host , port
rtn = "\r\n"
cmd = "GET #{path} HTTP/1.1#{rtn}"
cmd2 = "Host:#{host}#{rtn}"
cmd3 = "Connection:close #{rtn}"
cmd_end = rtn
pp cmd
sock.puts cmd
sock.puts cmd2
sock.puts cmd3
sock.puts cmd_end

isbody = false

while line = sock.gets
  puts line if isbody
  isbody = true if line == "\r\n"
end