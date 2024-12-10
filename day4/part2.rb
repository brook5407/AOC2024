def check_XMAS(content, pos_x, pos_y)
  return 0 if pos_y - 1 < 0 || pos_y + 1 >= content.size
  return 0 if pos_x - 1 < 0 || pos_x + 1 >= content[0].size

  return 0 unless content[pos_y][pos_x] == 'A'

  # Check the two diagonal "X" patterns
  diagonal1 = content[pos_y - 1][pos_x - 1] == 'M' && content[pos_y + 1][pos_x + 1] == 'S'
  diagonal2 = content[pos_y - 1][pos_x - 1] == 'S' && content[pos_y + 1][pos_x + 1] == 'M'
  diagonal3 = content[pos_y + 1][pos_x - 1] == 'M' && content[pos_y - 1][pos_x + 1] == 'S'
  diagonal4 = content[pos_y + 1][pos_x - 1] == 'S' && content[pos_y - 1][pos_x + 1] == 'M'

  ((diagonal1 || diagonal2) && (diagonal3 || diagonal4)) ? 1 : 0
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