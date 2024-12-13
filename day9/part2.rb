def create_blocks(numbers)
  blocks = []
  file_sizes = {}
  file_index = {}
  file_id = 0
  current_index = 0
  file = true

  numbers.each_with_index do |num, i|
    size = num.to_i
    blocks += file ? [file_id] * size : [nil] * size

    if file
      file_sizes[file_id] = size
      file_index[file_id] = current_index
      file_id += 1
    end

    current_index += size
    file = !file
  end

  [blocks, file_sizes, file_index]
end

def sort_blocks(blocks, file_sizes, file_index)
  start_search = Hash.new(0)
  file_sizes.reverse_each do |file_id, size|
    (start_search[size]...file_index[file_id]).each do |window_start|
      next unless blocks[window_start...window_start + size].all?(&:nil?)

      start_search[size] = window_start + size
      (0...size).each do |offset|
        blocks[window_start + offset] = file_id
        blocks[file_index[file_id] + offset] = nil
      end
      break
    end
  end
  blocks
end

def calculate_checksum(blocks)
  sum = 0
  blocks.each_with_index do |block, i|
    sum += block * i unless block.nil?
  end
  sum
end

def main(filename)
  numbers = File.read(filename).chomp.chars
  blocks, file_sizes, file_index = create_blocks(numbers)
  blocks = sort_blocks(blocks, file_sizes, file_index)
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
