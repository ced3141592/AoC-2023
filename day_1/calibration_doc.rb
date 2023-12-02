def find_first_digit(line)
  line.each_char do |char|
    return char if char.to_i > 0
  end
end

def merge_numbers(s)
  last_number = find_first_digit(s.reverse)
  first_number = find_first_digit(s)
  (first_number + last_number).to_i unless last_number.nil?
end

def main
  i = 0
  File.readlines("input.txt").each do |line|
    i += merge_numbers(line)
  end

  puts i
end

main
