def count_tokens(data)
  button_A = [data[0][0].to_i, data[0][1].to_i]
  button_B = [data[1][0].to_i, data[1][1].to_i]
  prize = [data[2][0].to_i + 10000000000000, data[2][1].to_i + 10000000000000]

  d = (button_A[0] * button_B[1]) - (button_A[1] * button_B[0])
  dx = (prize[0] * button_B[1]) - (prize[1] * button_B[0])
  dy = (button_A[0] * prize[1]) - (button_A[1] * prize[0])

  return 0 if d == 0 || dx % d != 0 || dy % d != 0

  x = dx / d
  y = dy / d
  x * 3 + y
end

def main(filename)
  data = []
  total = 0
  File.foreach(filename) do |line|
    if line.strip.empty?
      total += count_tokens(data)
      data = []
      next
    end
    content = line.split(" ")
    data << [content[-2][2..-1], content[-1][2..-1]]
  end
  total += count_tokens(data)
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