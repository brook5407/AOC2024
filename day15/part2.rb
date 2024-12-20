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
      if cell == '['
        sum += y * 100 + x
      end
    end
  end
  sum
end

def check_box(map, pos, dy, left, right)
  x, y = pos
  next_y = y + dy
  if map[next_y][x] == '['
    left.push([x, next_y])
    right.push([x + 1, next_y])
    return check_box(map, [x, next_y], dy, left, right) && check_box(map, [x + 1, next_y], dy, left, right)
  elsif map[next_y][x] == ']'
    right.push([x, next_y])
    left.push([x - 1, next_y])
    return check_box(map, [x, next_y], dy, left, right) && check_box(map, [x - 1, next_y], dy, left, right)
  else
    return map[next_y][x] == '.'
  end
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
  when '[', ']'
    if dir == '<' || dir == '>'
      object_x = next_x + dx
      object_y = next_y + dy
      while map[object_y][object_x] == '[' || map[object_y][object_x] == ']'
        object_x += dx
        object_y += dy
      end
      if object_x >= 0 && object_x < map[0].size && object_y >= 0 && object_y < map.size && map[object_y][object_x] == '.'
        map[y][x] = '.' 
        map[object_y].delete_at(object_x)
        map[next_y].insert(next_x, '@')
        return [next_x, next_y] 
      end
    elsif dir == '^' || dir == 'v'
      visited_left = []
      visited_right = []
      if check_box(map, [x, y], dy, visited_left, visited_right)
        visited_left.each do |pos|
          x, y = pos
          map[y][x] = '.'
        end
        visited_right.each do |pos|
          x, y = pos
          map[y][x] = '.'
        end
        visited_left.each do |pos|
          x, y = pos
          map[y+dy][x] = '['
        end
        visited_right.each do |pos|
          x, y = pos
          map[y+dy][x] = ']'
        end
        if map[next_y][next_x] == '['
          map[next_y][next_x + 1] = '.'
        elsif map[next_y][next_x] == ']'
          map[next_y][next_x - 1] = '.'
        end
        map[next_y][next_x] = '@'
        map[next_y - dy][next_x - dx] = '.'
        return [next_x, next_y]
      end
    end
  end
  pos 
end

def recreate_map(map)
  new_map = []
  map.each do |row|
    new_row = []
    row.each do |tile|
      case tile
      when '#'
        new_row.concat(['#', '#'])
      when 'O'
        new_row.concat(['[', ']'])
      when '@'
        new_row.concat(['@', '.'])
      else
        new_row.concat(['.', '.'])
      end
    end
    new_map.push(new_row)
  end
  new_map
end

def main(filename)
  map = File.read(filename).split("\n\n")[0].split("\n").map(&:chars)
  steps = File.read(filename).split("\n\n")[1].delete("\n")
  map = recreate_map(map)
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
