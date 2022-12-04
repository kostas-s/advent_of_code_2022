lines = File.readlines('day4.txt').map(&:chomp).map { |l| l.split(',') }
puts(lines.filter do |l|
  first = l[0].split('-')
  second = l[1].split('-')
  common = (first[0]..first[1]).to_a & (second[0]..second[1]).to_a
  common == (first[0]..first[1]).to_a || common == (second[0]..second[1]).to_a
end.count)
