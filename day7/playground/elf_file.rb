class ElfFile
  attr_reader :name, :size

  def initialize(name, size)
    @name = name
    @size = size.to_i
  end

  def name_min_size(size = 15)
    diff = size - name.length
    result = name.chars
    diff.times { result << ' ' } if diff.positive?
    result.join
  end
end
