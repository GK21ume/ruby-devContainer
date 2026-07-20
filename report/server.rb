#! usr/local/bin/ruby

require 'socket'
require 'openssl'

# サーバがやること
# 1.通信開始
# 1.5 公開鍵の送信
# 2.GETを待つ
# 2.5 復号する
# 3.GETされたファイルを探す
# 4.ファイルがあったら読み込んで内容を返す(めんどいのでこっちは平文)
# 5.無いなら404を返す(404ページを作る)(平文)


def server s
  # 鍵送信を挟む
  crypto = s.gets
  # ここでcryptoを復号する
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
      File.open("NotFound.html","f") do |f|
        s.print "HTTP/1.0 404 NotFound\r\n"
        s.print "content-Type: text/html\r\n"
        s.print "\r\n"
        while line = f.gets
          s.puts line
        end
      end
    end

    # pp "other"
    # s.puts "other"
  end
  s.close
end

# メインサーバの流れ
# 起動
# 鍵生成
# ループ
# 受信待ち
# 受信したらスレッド分けて対応
# ここまでループ
#


gs = TCPServer.open 'http'

loop do

  pp "start accept"
  s = gs.accept

  Thread.new do
    server s
  end

end