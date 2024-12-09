def main(filename)
  content = File.read(filename)
  total = 0

  pattern = /mul\((\d+),(\d+)\)/

  content.scan(pattern) do |a, b|
    total += a.to_i * b.to_i
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