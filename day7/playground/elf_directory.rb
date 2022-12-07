require './elf_file'

class ElfDirectory
  attr_reader :name, :files, :directories

  def initialize(name)
    @name = name
    @files = []
    @directories = []
  end

  def add_file(filename, size)
    @files << ElfFile.new(filename, size)
  end

  def open_directory(dirname)
    @directories.detect { |d| d.name == dirname } || add_directory(dirname)
  end

  def total_size
    files.map(&:size).sum(0) + @directories.map(&:total_size).sum(0)
  end

  def name_min_size(size = 15)
    diff = size - name.length
    result = name.chars
    diff.times { result << ' ' } if diff.positive?
    result.join
  end

  def ls
    (files.map { |f| "#{f.name_min_size}\t\t\t#{f.size}" } +
      directories.map { |d| "#{d.name_min_size}\t\t\tDIRECTORY" } +
      ["\t==TOTAL SIZE: #{total_size}=="]).join("\n")
  end

  private

  def add_directory(dirname)
    curr = ElfDirectory.new(dirname)
    @directories << curr
    curr
  end
end
