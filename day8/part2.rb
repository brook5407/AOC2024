require 'set'

def parse_input(grid)
  antennas = {}
  grid.each_with_index do |row, y|
    row.each_with_index do |char, x|
      next if char == '.'
      antennas[char] ||= []
      antennas[char] << [x, y]
    end
  end
  antennas
end

def is_in_map?(coord, grid)
    rows = grid.length
    cols = grid[0].length

    coord[0] >= 0 && coord[1] >= 0 && 
    coord[0] < rows && coord[1] < cols
end

def find_antinodes(antennas, grid)
  antinodes = Set.new

  antennas.each_value do |positions|
    positions.combination(2).each do |ant1, ant2|
      dx = ant2[0] - ant1[0]
      dy = ant2[1] - ant1[1]

      [[dx, dy], [-dx, -dy]].each do |step_x, step_y|
        puts "Step: #{step_x}, #{step_y}"
        current = [ant1[0] + step_x, ant1[1] + step_y]
        while is_in_map?(current, grid)
          antinodes.add(current)
          current = [current[0] + step_x, current[1] + step_y]
        end
        current = [ant2[0] + step_x, ant2[1] + step_y]
        while is_in_map?(current, grid)
          antinodes.add(current)
          current = [current[0] + step_x, current[1] + step_y]
        end
      end
    end
  end
  antinodes
end

def main(filename)
  grid = File.read(filename).split("\n").map(&:chars)
  antennas = parse_input(grid)
  count = find_antinodes(antennas, grid).size

  puts "Total: #{count}"
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