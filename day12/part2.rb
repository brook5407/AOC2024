def search_plant(garden, i, j, value, plants = [])
  rows, cols = garden.length, garden[0].length

  if i < 0 || i >= rows || j < 0 || j >= cols || garden[i][j] != value
    return
  end

  garden[i][j] = nil

  plants << [j, i]

  directions = [[0, 1], [0, -1], [1, 0], [-1, 0]]
  directions.each do |dx, dy|
    search_plant(garden, i + dx, j + dy, value, plants)
  end

  plants
end

def calculate_side(plants, rows, cols)
  return 4 if plants.length == 1

  sides = 0
  directions = [
    [-1, 0], [1, 0], [0, -1], [0, 1], 
    [-1, -1], [1, -1], [-1, 1], [1, 1] 
  ]

  plants.each do |x, y|
    neighbors = directions.map { |dx, dy| plants.include?([x + dx, y + dy]) }
    top, right, bottom, left = neighbors[2], neighbors[1], neighbors[3], neighbors[0]
    top_left, top_right, bottom_left, bottom_right = neighbors[4..7]

    sides += 1 if !top_right && ((top && right) || (!top && !right))
    sides += 1 if !top_left && ((top && left) || (!top && !left))
    sides += 1 if !bottom_left && ((bottom && left) || (!bottom && !left))
    sides += 1 if !bottom_right && ((bottom && right) || (!bottom && !right))
    sides += 1 if top_right && !top && !right
    sides += 1 if top_left && !top && !left
    sides += 1 if bottom_left && !bottom && !left
    sides += 1 if bottom_right && !bottom && !right
  end

  sides
end


def main(filename)
  garden = File.read(filename).split("\n").map(&:chars)
  total = 0
  rows, cols = garden.length, garden[0].length

  garden.each_with_index do |row, y|
    row.each_with_index do |cell, x|
      if cell
        plants = search_plant(garden, y, x, cell)
        total += calculate_side(plants, rows, cols) * plants.length
      end
    end
  end

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