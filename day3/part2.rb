def find_pattern(do_content, total)
  pattern = /mul\((\d+),(\d+)\)/
  do_content.scan(pattern) do |a, b|
    total += a.to_i * b.to_i
  end
  total
end

def main(filename)
  total = 0
  content = File.read(filename)

  parts = content.split("don't()")

  total = find_pattern(parts[0], total) if parts[0] && !parts[0].empty?

  parts.drop(1).each do |part|
    do_content = part.split("do()")
    do_content.drop(1).each do |segment|
      total = find_pattern(segment, total)
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
  main(filename)
end
