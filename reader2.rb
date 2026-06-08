#2.rb

File.open("hello.txt", "w") do |f|
    while line = f.gets
        puts line
    end
end