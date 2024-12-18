def search_plant(garden, i, j, value, plants = [])
  rows, cols = garden.length, garden[0].length

  if i < 0 || i >= rows || j < 0 || j >= cols || garden[i][j] != value
    return
  end

  garden[i][j] = nil

  plants << [i, j]

  directions = [[0, 1], [0, -1], [1, 0], [-1, 0]]
  directions.each do |dx, dy|
    search_plant(garden, i + dx, j + dy, value, plants)
  end

  plants
end

def calculate_perimeter(plants, rows, cols)
  perimeter = 0
  directions = [[0, 1], [0, -1], [1, 0], [-1, 0]]

  plants.each do |i, j|
    directions.each do |dx, dy|
      ni, nj = i + dx, j + dy

      if ni < 0 || ni >= rows || nj < 0 || nj >= cols || !plants.include?([ni, nj])
        perimeter += 1
      end
    end
  end

  perimeter
end

def main(filename)
  garden = File.read(filename).split("\n").map(&:chars)
  total = 0
  rows, cols = garden.length, garden[0].length

  garden.each_with_index do |row, y|
    row.each_with_index do |cell, x|
      if cell
        plants = search_plant(garden, y, x, cell)
        total += calculate_perimeter(plants, rows, cols) * plants.length
      end
    end
  end

  puts "Total perimeter: #{total}"
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