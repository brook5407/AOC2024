$dir = {'^' => [0, -1], 'v' => [0, 1], '<' => [-1, 0], '>' => [1, 0]}

def find_start(map)
  map.each_with_index do |row, y|
    x = row.index('@')
    return [x, y] if x
  end
  nil
end

def sum_GPS(map)
  sum = 0
  map.each_with_index do |row, y|
    row.each_with_index do |cell, x|
      sum += y * 100 + x if cell == 'O'
    end
  end
  sum
end

def move(map, pos, dir)
  x, y = pos
  dx, dy = $dir[dir]
  next_x = x + dx
  next_y = y + dy

  return pos if next_y < 0 || next_y >= map.size || next_x < 0 || next_x >= map[next_y].size

  case map[next_y][next_x]
  when '.'
    map[y][x] = '.' 
    map[next_y][next_x] = '@'
    return [next_x, next_y] 
  when 'O'
    object_x = next_x + dx
    object_y = next_y + dy
    while map[object_y][object_x] == 'O'
      object_x += dx
      object_y += dy
    end
    if object_x >= 0 && object_x < map[0].size && object_y >= 0 && object_y < map.size && map[object_y][object_x] == '.'
      map[object_y][object_x] = 'O' 
      map[next_y][next_x] = '@' 
      map[y][x] = '.' 
      return [next_x, next_y] 
    end
  end
  pos 
end



def main(filename)
  map = File.read(filename).split("\n\n")[0].split("\n").map(&:chars)
  steps = File.read(filename).split("\n\n")[1].delete("\n")
  start = find_start(map)
  steps.each_char do |step|
    start = move(map, start, step)
  end
  puts "total GPS: #{sum_GPS(map)}"
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
