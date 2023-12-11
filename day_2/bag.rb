class Bag
  def initialize(red_cubes, green_cubes, blue_cubes)
    @red_cubes = red_cubes
    @green_cubes = green_cubes
    @blue_cubes = blue_cubes
    @reset = [red_cubes, green_cubes, blue_cubes]
  end

  def take_cubes(color, amount)
    case color
    when "red"
      @red_cubes -= amount
    when "green"
      @green_cubes -= amount
    when "blue"
      @blue_cubes -= amount
    end
  end

  def is_valid
    @red_cubes < 0 || @green_cubes < 0 || @blue_cubes < 0 ? false : true
  end

  def reset
    @red_cubes = @reset[0]
    @green_cubes = @reset[1]
    @blue_cubes = @reset[2]
  end
end
