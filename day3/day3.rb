lines = File.readlines('day3.txt').map(&:chomp)
values = ('a'..'z').to_a + ('A'..'Z').to_a
puts("Part A: #{
  lines.map do |l|
    parts = [l[0...(l.length/2)], l[(l.length/2)..]]
    duplicates = parts[0].chars.uniq.filter { |char| parts[1].chars.include? char }
    duplicates.map { |d| values.index(d) + 1 }.sum(0)
  end.sum(0)}")
