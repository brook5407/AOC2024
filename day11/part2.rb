def main(filename)
  numbers = File.read(filename).split(" ").map(&:to_i)
  75.times do |round|
    puts "Round: #{round}"
    new_numbers = []
    numbers.each do |num|
      if num == 0
        new_numbers << 1
      elsif num.to_s.length.even?
        half = 10 ** (num.to_s.length / 2)
        new_numbers << (num / half)
        new_numbers << (num % half)
      else
        new_numbers << (num * 2024)
      end
    end
    
    numbers = new_numbers
  end
  total = numbers.size
  puts "Total: #{total}"
end

if __FILE__ == $PROGRAM_NAME
  require 'set'

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