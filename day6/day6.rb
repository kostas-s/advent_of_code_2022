class SignalAnalyzer
  attr_reader :signal_array

  def initialize(signal_array)
    @signal_array = signal_array
  end

  def detect_uniq_signal(len)
    chars = signal_array.dup.reverse
    result = []
    (len - 1).times { result << chars.pop }
    while chars.any? && result << chars.pop
      from = (result.length - len)
      to = result.length
      break if result[from...to].uniq == result[from...to]
    end
    result.count
  end
end

analyzer = SignalAnalyzer.new(File.read('input.txt').chars)
puts "Part A: #{analyzer.detect_uniq_signal(4)}"
puts "Part B: #{analyzer.detect_uniq_signal(14)}"
