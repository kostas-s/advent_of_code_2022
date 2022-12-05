class Cargo
  attr_reader :stacks

  def initialize(cargo_lines)
    @stacks = {}
    build_stacks(cargo_lines)
  end

  def build_stacks(cargo_lines)
    cargo_lines = cargo_lines.split("\n")
    cargo_lines.pop # Reject the last line
    cargo_lines.reverse.each do |p|
      result = p.chars.each_slice(4).map(&:join).map { |pp| pp.gsub('[', '').gsub(']', '') }.map(&:strip)
      result.each_with_index do |ppp, i|
        stacks[i + 1] ||= []
        stacks[i + 1].push(ppp) if ppp != ''
      end
    end
  end

  def transfer_cargo_a(count, from, to)
    count.times { stacks[to] << stacks[from].pop }
  end

  def transfer_cargo_b(count, from, to)
    stacks[to] += stacks[from].pop(count)
  end

  def top_cargo
    stacks.keys.map do |k|
      stacks[k].last
    end.join
  end
end

# Part A
parts = File.read('input.txt').split("\n\n")
cargo_a = Cargo.new(parts[0])
parts[1].split("\n").map(&:chomp).each do |line|
  count, from, to = line.scan(/\d+/).map(&:to_i)
  cargo_a.transfer_cargo_a(count, from, to)
end

puts "Part A: #{cargo_a.top_cargo}"

# Part B
cargo_b = Cargo.new(parts[0])
parts[1].split("\n").map(&:chomp).each do |line|
  count, from, to = line.scan(/\d+/).map(&:to_i)
  cargo_b.transfer_cargo_b(count, from, to)
end

puts "Part B: #{cargo_b.top_cargo}"
