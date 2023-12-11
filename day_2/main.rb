require_relative "bag"
require "colorize"

class InputParseError < StandardError
end

def load_input(path)
  puts "loading input..."
  input = File.open(path)
  games = Hash.new
  input.each do |line|
    match = line.match(/Game (\d+):/)
    game_id = match[1].to_i
    raise InputParseError if game_id == 0
    games[game_id] = parse_input_line(line)
  end
  puts "done\n"
  return games
end

def parse_input_line(s)
  rounds = s.split(":")[1].split(";")
  game = []
  rounds.each do |round|
    round = round.split(",")
    result = Hash.new
    round.each do |r|
      cubes = r.split(" ")
      amount = cubes[0]
      color = cubes[1]
      raise InputParseError if amount.nil?
      result[color] = amount.to_i
    end
    game << (result)
  end
  return game
end

def is_valid_game(game, bag)
  bag.reset
  game.all? do |round|
    round.all? do |color, amount|
      bag.take_cubes(color, amount) && bag.is_valid
    end.tap { bag.reset }
  end
end

def add_ids(games, bag)
  games.sum { |id, game| is_valid_game(game, bag) ? id : 0 }
end

def calculate_power(cubes)
  cubes.values.inject(:*)
end

def part_1(games, bag)
  sum_ids = add_ids(games, bag)
  puts sum_ids
end

def part_2(games)
  sum_of_power = games.values.sum do |round|
    min_cubes = round.inject(Hash.new) do |min_cubes, grab|
      min_cubes = min_cubes.merge(grab) { |key, old_value, new_value| [old_value, new_value].max }
    end
    calculate_power(min_cubes)
  end
  puts sum_of_power
end

def main
  bag = Bag.new(12, 13, 14)
  games = load_input("input.txt")

  puts "\n--- part 1 ---"
  part_1(games, bag)
  puts "\n--- part 2 ---"
  part_2(games)
end

main
