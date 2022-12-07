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

  private

  def add_directory(dirname)
    curr = ElfDirectory.new(dirname)
    @directories << curr
    curr
  end
end
