def find_possible_trail(map, x, y)
  num = map[y][x].to_i
  score = (num == 9 ? 1 : 0)

  directions = [
    [0, 1],  
    [0, -1],  
    [1, 0],   
    [-1, 0]  
  ]

  directions.each do |dx, dy|
    new_x = x + dx
    new_y = y + dy

    if new_y >= 0 && new_y < map.size &&
       new_x >= 0 && new_x < map[new_y].size &&
       map[new_y][new_x].to_i == num + 1
      
      score += find_possible_trail(map, new_x, new_y)
    end
  end

  score
end

def main(filename)
  total = 0
  map = File.read(filename).split("\n").map(&:chars)
  visited = Set.new

  map.each_with_index do |row, y|
    row.each_with_index do |pos, x|
      if pos == '0'
        total += find_possible_trail(map, x, y)
      end
    end
  end

  puts "Total: #{total}"
end

if __FILE__ == $PROGRAM_NAME
  require 'set'

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