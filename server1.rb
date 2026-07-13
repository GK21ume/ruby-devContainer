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
  elsif path == "/api/now"
    s.print "HTTP/1.0 200 OK\r\n"
        s.print "content-Type: application/json; charset=UTF-8\r\n"
        s.print "\r\n"
        s.puts "{"
        s.puts '"time" :"' + "#{Time.now}" + '"'
        s.puts "}"
  else
    file = path.slice 1..-1
    pp file
    if File.exist? file
      File.open(file, "r") do |f|
        s.print "HTTP/1.0 200 OK\r\n"
        s.print "content-Type: text/plain; charset=UTF-8\r\n"
        s.print "\r\n"
        while line = f.gets
          s.puts line
        end
      end
    else
      s.print "HTTP/1.0 404 NotFound\r\n"
      s.print "content-Type: text/html\r\n"
      s.print "\r\n"
      s.puts "<h1>404 Not Found" + '<\h1><br>'
      s.puts "<a>" + path + " is not found in this server"
    end

    # pp "other"
    # s.puts "other"
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