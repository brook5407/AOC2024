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
      dx = ant1[0] - ant2[0]
      dy = ant1[1] - ant2[1]
      
      anti1 = [ant1[0] + dx, ant1[1] + dy]
      anti2 = [ant2[0] - dx, ant2[1] - dy]
      antinodes.add(anti1) if is_in_map?(anti1, grid)
      antinodes.add(anti2) if is_in_map?(anti2, grid)
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