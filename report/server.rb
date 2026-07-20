#! usr/local/bin/ruby

require socket

# サーバがやること
# 1.通信開始
# 1.5 公開鍵の送信
# 2.GETを待つ
# 2.5 復号する
# 3.GETされたファイルを探す
# 4.ファイルがあったら読み込んで内容を返す(めんどいのでこっちは平文)
# 5.無いなら404を返す(404ページを作る)(平文)


def server s
  cmd , path , ver = s.gets.split " "
  if path == "/"
    pp "index"
    s.print "HTTP/1.0 200 OK\r\n"
    s.print "content-Type: text/html\r\n"
    s.print "\r\n"
    s.puts "index"
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