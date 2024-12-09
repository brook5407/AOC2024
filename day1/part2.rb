def main(filename)
  file = File.open(filename)
  content = file.read.split.map(&:to_i) 
  file.close

  ary_left = []
  ary_right = []

  content.each_with_index do |num, i|
    if i.even?
      ary_left << num
    else
      ary_right << num
    end
  end

  total = 0
  min_size = [ary_left.size, ary_right.size].min
  (0...min_size).each do |i|
    total += ary_left[i] * ary_right.count(ary_left[i])
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
