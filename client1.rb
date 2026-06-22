#! /usr/local/bin/ruby
# client1.ruby

require 'socket'

host = ARGV[0]
port = 'http'
if ARGV[1] == nil
  path = '/'
else
  path = ARGV[1]
end
pp path

sock = TCPSocket.new host , port
rtn = "\r\n"
cmd = "GET #{path} HTTP/1.1#{rtn}"
cmd2 = "Host:#{host}#{rtn}"
cmd3 = "Connection:close #{rtn}"
cmd_end = rtn
sock.puts cmd
sock.puts cmd2
sock.puts cmd3
sock.puts cmd_end

isbody = false

while line = sock.gets
  puts line if isbody
  isbody = true if line == "\r\n"
end