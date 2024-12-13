def create_blocks(numbers)
  numbers.flat_map.with_index do |num, i|
    Array.new(num.to_i) { i.even? ? [(i / 2).to_s] : [nil] }
  end
end

def sort_blocks(blocks)
  last_index = blocks.size - 1

  blocks.each_with_index do |block, i|
    next unless block == [nil]
    break if i >= last_index

    blocks[i], blocks[last_index] = blocks[last_index], blocks[i]
    last_index -= 1 while blocks[last_index] == [nil] && last_index > 0
  end
end

def calculate_checksum(blocks)
  sum = 0
  blocks.each_with_index do |block, i|
    sum += block[0].to_i * i unless block.nil?
  end
  sum
end

def main(filename)
  numbers = File.read(filename).chomp.chars
  blocks = create_blocks(numbers)
  sort_blocks(blocks)
  total = calculate_checksum(blocks)

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
