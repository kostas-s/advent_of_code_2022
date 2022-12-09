# frozen_string_literal: true
require 'pry'
require './point'

class Head < Point
end

class Tail < Point
  def follow_head(head)
    return if touching_point?(head)

    if @x == head.x
      # Vertical move
      move_by(y: (head.y - @y).positive? ? 1 : -1)
    elsif @y == head.y
      # Horizontal move
      move_by(x: (head.x - @x).positive? ? 1 : -1)
    else
      # Diagonal move
      x_amount = (head.x - @x).positive? ? 1 : -1
      y_amount = (head.y - @y).positive? ? 1 : -1
      move_by(x: x_amount, y: y_amount)
    end
  end
end

class InputParser
  attr_reader :head, :tail, :input

  def initialize(head, tail, input)
    @head = head
    @tail = tail
    @input = input
  end

  def analyze!
    @input.each do |line|
      parts = line.split
      parts[1].to_i.times { move_head(parts[0]) }
    end
  end

  def move_head(direction)
    case direction
    when 'L'
      @head.move_by(x: -1)
    when 'R'
      @head.move_by(x: 1)
    when 'U'
      @head.move_by(y: 1)
    else
      @head.move_by(y: -1)
    end
    @tail.follow_head(@head)
  end
end

head = Head.new
tail = Tail.new
input = File.readlines('input.txt').map(&:chomp)
ip = InputParser.new(head, tail, input)
ip.analyze!
puts "Part A: #{tail.all_points.count}"
