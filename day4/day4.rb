lines = File.readlines('day4.txt').map(&:chomp).map { |l| l.split(',') }

def line_to_range_arrays(l)
  first = l[0].split('-')
  second = l[1].split('-')
  [(first[0]..first[1]).to_a, (second[0]..second[1]).to_a]
end

# Part A
puts("Part A: #{lines.filter do |l|
  ranges = line_to_range_arrays(l)
  common = ranges[0] & ranges[1]
  common == ranges[0] || common == ranges[1]
end.count}")

# Part B
puts("Part B: #{lines.filter do |l|
  ranges = line_to_range_arrays(l)
  (ranges[0] & ranges[1]).any?
end.count}")
