class Elf
  attr_reader :total_food

  def initialize
    @total_food = 0
  end

  def add_food(food)
    @total_food += food
  end
end

elves = []
e = Elf.new

lines = File.readlines('day1a.txt').map(&:strip)
lines.each do |line|
  if line == ''
    elves << e
    e = Elf.new
    next
  end
  e.add_food line.to_i
end

puts elves.map(&:total_food).max
puts elves.map(&:total_food).sort.reverse[0..2].sum(0)
