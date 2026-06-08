# reader.rb

f = File.open "hellp.rb", "r"

while line = f.gets
    puts line
end

f.close