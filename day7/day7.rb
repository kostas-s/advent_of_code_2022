require './elf_file_system'

file_lines = File.readlines('input.txt')
fs = ElfFileSystem.new(file_lines)
puts("Part A: #{fs.directories.filter { |d| d.total_size <= 100000 }.map(&:total_size).sum(0)}")
