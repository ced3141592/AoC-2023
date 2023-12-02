INPUT = "input.txt"

def find_composed_number(line)
  first = nil
  last = nil
  i = 0
  line.each_char do |char|
    num = nil
    num = char.to_i if char.to_i > 0
    num ||= get_verbose_number(line[i..-1])
    first ||= num
    last = num unless num.nil?
    i += 1
  end
  (first.to_s + last.to_s).to_i
end

def get_verbose_number(s)
  return nil if s.length < 3

  numbers = {
    "one" => 1,
    "two" => 2,
    "three" => 3,
    "four" => 4,
    "five" => 5,
    "six" => 6,
    "seven" => 7,
    "eight" => 8,
    "nine" => 9,
  }

  numbers.each_key { |key| return numbers[key] if s.start_with?(key) }
  nil
end

def main
  puts File.readlines(INPUT).sum { |line| find_composed_number(line) }
end

main
