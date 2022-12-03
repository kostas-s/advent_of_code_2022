lines = File.readlines('day3.txt').map(&:chomp)
values = ('a'..'z').to_a + ('A'..'Z').to_a

# Part A
puts("Part A: #{
  lines.map do |l|
    parts = [l[0...(l.length/2)], l[(l.length/2)..]]
    duplicates = parts[0].chars.uniq.filter { |char| parts[1].chars.include? char }
    duplicates.map { |d| values.index(d) + 1 }.sum(0)
  end.sum(0)}")

# Part B
part_b_result = 0
lines.each_slice(3) do |x, y, z|
  groups = [x, y, z].map { |el| el.chars.uniq }
  common_char = (groups[0] & groups[1] & groups[2]).first
  part_b_result += (values.index(common_char) + 1)
end

puts("Part B: #{part_b_result}")
