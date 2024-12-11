def find_start(map)
  map.each_with_index do |row, y|
    x = row.index('^')
    return [x, y] if x
  end
  nil
end

def move(map, x, y)
  steps = 0
  loop do
    steps += 1

    return false if steps > 10000

    case map[y][x]
    when '>'
      if x == map[0].size - 1 || map[y][x + 1] == '#'
        map[y][x] = 'v'
      else
        map[y][x] = 'X'
        map[y][x + 1] = '>'
        x += 1
      end
    when 'v'
      if y == map.size - 1 || map[y + 1][x] == '#'
        map[y][x] = '<'
      else
        map[y][x] = 'X'
        map[y + 1][x] = 'v'
        y += 1
      end
    when '<'
      if x == 0 || map[y][x - 1] == '#'
        map[y][x] = '^'
      else
        map[y][x] = 'X'
        map[y][x - 1] = '<'
        x -= 1
      end
    when '^'
      if y == 0 || map[y - 1][x] == '#'
        map[y][x] = '>'
      else
        map[y][x] = 'X'
        map[y - 1][x] = '^'
        y -= 1
      end
    else
      return true
    end

    return true if x == 0 || x == map[0].size - 1 || y == 0 || y == map.size - 1
  end
end

def main(filename)
  map = File.read(filename).split("\n").map(&:chars)
  x, y = find_start(map)

  unless x && y
    puts "Error: No starting position '^' found in the map."
    exit(1)
  end

  count = 0
  map.each_with_index do |row, y_map|
    row.each_with_index do |pos, x_map|
      if pos == '.'
        new_map = Marshal.load(Marshal.dump(map)) 
        new_map[y_map][x_map] = '#' 
        count += move(new_map, x, y) ? 0 : 1
      end
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
