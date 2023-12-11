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

# red=>12, green=>13, blue=>14
def filter_valid_games(games, bag)
  games.each do |id, round|
    is_invalid_game = false
    round.each do |grabs|
      grabs.each do |color, amount|
        bag.take_cubes(color, amount)
        unless bag.is_valid
          #   puts id, grabs
          games.delete(id)
          bag.reset
          is_invalid_game = true
          break
        end
        bag.reset
      end
      break if is_invalid_game
    end
  end
  games
end

def add_ids(games)
  i = 0
  games.each do |id, _|
    i += id
  end
  return i
end

def main
  bag = Bag.new(12, 13, 14)
  games = load_input("input.txt")
  valid_games = filter_valid_games(games, bag)
  puts
  puts add_ids(valid_games)
end

main
