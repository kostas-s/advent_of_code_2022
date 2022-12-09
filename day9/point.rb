# frozen_string_literal: true

class Point
  attr_accessor :x, :y, :visited_points

  def initialize
    @x = 0
    @y = 0
    @visited_points = [[@x, @y]]
  end

  def move_by(x: 0, y: 0)
    @x += x
    @y += y
    @visited_points << [@x, @y]
  end

  def all_points
    @visited_points.uniq
  end

  def touching_point?(other_point)
    (@x - other_point.x).abs <= 1 && (@y - other_point.y).abs <= 1
  end
end
