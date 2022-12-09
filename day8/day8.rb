class QuadCopter
  attr_reader :viewed_trees, :trees

  def initialize(trees)
    @trees = trees
    @viewed_trees = Array.new(trees.count) { Array.new(trees[0].count) { '' } }
  end

  # Part A

  def scan
    scan_horizontally
    @trees = @trees.transpose
    @viewed_trees = @viewed_trees.transpose
    scan_horizontally
  end

  def scan_horizontally
    trees = @trees
    (0...(trees.count)).each do |line_idx|
      curr_max = 0

      # Left to Right
      (0...(trees[0].count)).each do |tree_idx|
        if tree_idx.zero?
          curr_max = trees[line_idx][tree_idx].to_i
          next viewed_trees[line_idx][tree_idx] = 'X'
        end
        next if trees[line_idx][tree_idx].to_i <= curr_max

        curr_max = [curr_max, trees[line_idx][tree_idx].to_i].max
        viewed_trees[line_idx][tree_idx] = 'X'
      end

      # Right to Left
      (0...(trees[0].count)).to_a.reverse.each do |tree_idx|
        if tree_idx == trees[line_idx].count - 1
          curr_max = trees[line_idx][tree_idx].to_i
          next viewed_trees[line_idx][tree_idx] = 'X'
        end
        next if trees[line_idx][tree_idx].to_i <= curr_max

        curr_max = [curr_max, trees[line_idx][tree_idx].to_i].max
        viewed_trees[line_idx][tree_idx] = 'X'
      end
    end
  end

  def count_viewed
    @viewed_trees.map do |line|
      line.map { |tree| tree == 'X' ? 1 : 0 }.sum(0)
    end.sum(0)
  end

  # Part B

  def best_scenic_score
    (0...@viewed_trees.count).map do |y|
      (0...@viewed_trees[0].count).map do |x|
        @viewed_trees[y][x] = scan_from_idx(y, x)
      end.max
    end.max
  end

  def score_for_range(range, y, x, horizontal = true)
    curr_height = @trees[y][x].to_i
    to_add = 0
    range.each do |idx|
      to_add += 1
      if horizontal
        break if @trees[y][idx].to_i >= curr_height
      elsif @trees[idx][x].to_i >= curr_height
        break
      end
    end
    to_add
  end

  def scan_from_idx(y, x)
    scores = []
    scores << score_for_range((0...x).to_a.reverse, y, x)
    scores << score_for_range(((x + 1)...@trees[0].count), y, x)
    scores << score_for_range((0...y).to_a.reverse, y, x, false)
    scores << score_for_range(((y + 1)...@trees[0].count), y, x, false)
    scores.inject(:*)
  end
end

trees = File.readlines('input.txt').map(&:chomp).map(&:chars)
qc = QuadCopter.new(trees)
qc.scan
puts "Part A: #{qc.count_viewed}"
puts "Part B: #{qc.best_scenic_score}"
