def calculate_total(number, depth, cache)
  return 0 if depth >= 25
  return cache.dig(number, depth) if cache.dig(number, depth)

  total = 1
  cache[number] ||= {}

  if number == 0
    cache[number][depth] = calculate_total(1, depth + 1, cache)
    total = cache[number][depth]
  elsif number.to_s.length.even?
    str_number = number.to_s
    mid = str_number.length / 2
    left, right = str_number[0...mid].to_i, str_number[mid..-1].to_i

    left_result = cache.dig(left, depth + 1) || calculate_total(left, depth + 1, cache)
    cache[left] ||= {}
    cache[left][depth + 1] = left_result

    right_result = cache.dig(right, depth + 1) || calculate_total(right, depth + 1, cache)
    cache[right] ||= {}
    cache[right][depth + 1] = right_result

    total += left_result + right_result
    cache[number][depth] = total
  else
    cache[number][depth] = calculate_total(number * 2024, depth + 1, cache)
    total = cache[number][depth]
  end

  total
end

def main(filename)
  stones = File.read(filename).split(" ").map(&:to_i)
  total = stones.length
  memo = {}

  stones.each do |stone|
    total += calculate_total(stone, 0, memo)
  end

  puts total
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