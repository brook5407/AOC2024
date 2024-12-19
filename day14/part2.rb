$wide = 101
$tall = 103

def main(filename)
  wide_middle = $wide / 2
  tall_middle = $tall / 2
  total_robots = File.read(filename).split("\n").length
  times = 0
  loop do
    times += 1
    check_dup = []
    File.foreach(filename) do |robot|
      p = robot.match(/p=(-?\d+),(-?\d+)/)
      v = robot.match(/v=(-?\d+),(-?\d+)/)
      x = (p[1].to_i + (v[1].to_i * times)) % $wide
      y = (p[2].to_i + (v[2].to_i * times)) % $tall
      if check_dup.any? { |c| c == [x, y] }
        next
      else
        check_dup << [x, y]
      end
    end
    break if check_dup.length == total_robots
  end
  puts "Total: #{times}"
end

if __FILE__ == $PROGRAM_NAME
  if ARGV.length != 1
    puts "Usage: ruby script_name.rb <filename>"
    exit(1)
  end

  filename = ARGV[0]
  unless File.exist?(filename)
    puts "Error: File '#{filename}' not found."
    exit(1)
  end

  main(filename)
end