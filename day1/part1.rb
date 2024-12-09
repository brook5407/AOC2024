def main(filename)
  file = File.open(filename)
  content = file.read.split.map(&:to_i) 

  ary_left = []
  ary_right = []

  content.each_with_index do |num, i|
    if i.even?
      ary_left << num
    else
      ary_right << num
    end
  end

  ary_left.sort!
  ary_right.sort!

  total = 0
  min_size = [ary_left.size, ary_right.size].min
  (0...min_size).each do |i|
    total += (ary_right[i] - ary_left[i]).abs
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
