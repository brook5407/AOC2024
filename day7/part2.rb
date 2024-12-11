def concatenate(a, b)
  (a.to_s + b.to_s).to_i
end

def can_match(numbers, target, index, current_value)
  return current_value == target if index == numbers.length

  next_number = numbers[index]

  return true if can_match(numbers, target, index + 1, current_value + next_number)

  return true if can_match(numbers, target, index + 1, current_value * next_number)

  return true if can_match(numbers, target, index + 1, concatenate(current_value, next_number))

  false
end

def main(filename)
  total = 0

  File.foreach(filename) do |line|
    target, numbers = line.split(':').map(&:strip)
    target = target.to_i
    numbers = numbers.split.map(&:to_i)

    if can_match(numbers, target, 1, numbers[0])
      total += target
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
