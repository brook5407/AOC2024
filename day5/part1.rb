def can_process_query(array_map, remaining_query, current_num)
  remaining_query.all? { |num| !array_map[current_num].include?(num) }
end

def main(filename)
  adjacency_map = Array.new(100) { [] } 
  queries = []                        

  # Parse the input file
  File.foreach(filename) do |line|
    if line.include?('|')
      pair = line.strip.split('|').map(&:to_i)
      adjacency_map[pair[1]].push(pair[0])
    elsif line.include?(',')
      queries.push(line.strip.split(',').map(&:to_i))
    end
  end

  total = 0
  queries.each do |query|
    query.each_with_index do |num, index|
      if index == query.length - 1
        total += query[query.length / 2] 
      elsif !can_process_query(adjacency_map, query[(index + 1)..], num)
        break 
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
