#! /usr/local/bin/ruby
# server1.rb

require 'socket'

def server s
  cmd , path , ver = s.gets.split " "
  # HTTP/1.0として正しく返答
  # 1行目 HTTP/1.0 200 OK
  # 2 content-Type text/html
  # 3 空行
  # 4 コンテンツ
  # 最後 ソケットクローズ
  if path == "/"
    pp "index"
    s.print "HTTP/1.0 200 OK\r\n"
    s.print "content-Type: text/html\r\n"
    s.print "\r\n"
    s.puts "index"
  else
    pp "other"
    s.print "HTTP/1.0 200 OK\r\n"
    s.print "content-Type: text/html\r\n"
    s.print "\r\n"
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