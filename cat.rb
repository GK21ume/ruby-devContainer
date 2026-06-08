#! /usr/local/bin/ruby

File.open(ARGV[0], "r") do |f|
    while line = f.gets
        puts line
    end
end