def is_ascending(arry)
  for i in 0...(arry.size - 1)
    return false if arry[i] >= arry[i + 1] || arry[i + 1] - arry[i] > 3
  end
  true
end

def is_descending(arry)
  for i in 0...(arry.size - 1)
    return false if arry[i] <= arry[i + 1] || arry[i] - arry[i + 1] > 3
  end
  true
end

def check_line(line)
  arry = line.split.map(&:to_i)
  is_ascending(arry) || is_descending(arry) ? 1 : 0
end

def main(filename)
  total = 0
  File.foreach(filename) do |line|
    total += check_line(line)
  end

  puts "Total: #{total}"
end

if __FILE__ == $PROGRAM_NAME
  if ARGV.length != 1
    puts "Usage: ruby script_name.rb <filename>"
    exit(1)
  end

  filename = ARGV[0]
  main(filename)
end
