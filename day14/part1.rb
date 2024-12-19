$times = 100
$wide = 101
$tall = 103

def main(filename)
  wide_middle = $wide / 2
  tall_middle = $tall / 2
  output = [0, 0, 0, 0]
  File.foreach(filename) do |robot|
    p = robot.match(/p=(-?\d+),(-?\d+)/)
    v = robot.match(/v=(-?\d+),(-?\d+)/)
    x = (p[1].to_i + (v[1].to_i * $times)) % $wide
    y = (p[2].to_i + (v[2].to_i * $times)) % $tall
    output[0] += 1 if x < wide_middle && y < tall_middle
    output[1] += 1 if x > wide_middle && y < tall_middle
    output[2] += 1 if x < wide_middle && y > tall_middle
    output[3] += 1 if x > wide_middle && y > tall_middle
  end
  total = output[0] * output[1] * output[2] * output[3]
  puts "Total: #{total}"
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