def check_XMAS(content, pos_x, pos_y)
  directions = [
    [0, 1],  
    [1, 0],
    [0, -1], 
    [-1, 0], 
    [1, 1],  
    [-1, -1],
    [1, -1],
    [-1, 1]  
  ]

  directions.count do |dx, dy|
    0.upto(3).all? do |i|
      new_y = pos_y + i * dy
      new_x = pos_x + i * dx
      new_y.between?(0, content.size - 1) &&
      new_x.between?(0, content[0].size - 1) &&
      content[new_y][new_x] == 'XMAS'[i]
    end
  end
end

def main(filename)
  content = File.read(filename).split("\n").map(&:chars)

  count = 0
  content.each_with_index do |row, y|
    row.each_with_index do |_, x|
      count += check_XMAS(content, x, y)
    end
  end

  puts "Total: #{count}"
end

if __FILE__ == $PROGRAM_NAME
  if ARGV.length != 1
    puts "Usage: ruby script_name.rb <filename>"
    exit(1)
  end

  filename = ARGV[0]
  main(filename)
end