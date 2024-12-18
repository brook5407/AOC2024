def search_plant(garden, i, j, value, plants = [])
  rows, cols = garden.length, garden[0].length

  # Check if the current cell is out of bounds or not the target value
  if i < 0 || i >= rows || j < 0 || j >= cols || garden[i][j] != value
    return
  end

  # Mark the cell as visited
  garden[i][j] = nil

  # Add the current cell to the list of plants
  plants << [j, i]

  # Explore 4 directions
  directions = [[0, 1], [0, -1], [1, 0], [-1, 0]]
  directions.each do |dx, dy|
    search_plant(garden, i + dx, j + dy, value, plants)
  end

  plants
end

def calculate_side(plants, rows, cols)
  sides = 0
  return 4 if plants.length == 1

  plants.each do |x, y|
    left_neighbor = plants.include?([x-1, y])
    right_neighbor = plants.include?([x+1, y])
    top_neighbor = plants.include?([x, y-1])
    bottom_neighbor = plants.include?([x, y+1])
    left_top = plants.include?([x-1, y-1])
    right_top = plants.include?([x+1, y-1])
    left_bottom = plants.include?([x-1, y+1])
    right_bottom = plants.include?([x+1, y+1])

    if !right_top && ((top_neighbor && right_neighbor) || (!top_neighbor && !right_neighbor))
      sides += 1
    end
    if !left_top && ((top_neighbor && left_neighbor) || (!top_neighbor && !left_neighbor))
      sides += 1
    end
    if !left_bottom && ((bottom_neighbor && left_neighbor) || (!bottom_neighbor && !left_neighbor))
      sides += 1
    end
    if !right_bottom && ((bottom_neighbor && right_neighbor) || (!bottom_neighbor && !right_neighbor))
      sides += 1
    end
    if right_top && !top_neighbor && !right_neighbor
      sides += 1
    end
    if left_top && !top_neighbor && !left_neighbor
      sides += 1
    end
    if left_bottom && !bottom_neighbor && !left_neighbor
      sides += 1
    end
    if right_bottom && !bottom_neighbor && !right_neighbor
      sides += 1
    end
  end
  sides
end

def main(filename)
  garden = File.read(filename).split("\n").map(&:chars)
  total = 0
  rows, cols = garden.length, garden[0].length

  garden.each_with_index do |row, y|
    row.each_with_index do |cell, x|
      # Only run search_plant if the cell is not nil
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