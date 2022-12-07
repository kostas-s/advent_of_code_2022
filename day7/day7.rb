require './elf_file_system'

file_lines = File.readlines('input.txt')
fs = ElfFileSystem.new(file_lines)
puts("Part A: #{fs.directories.filter { |d| d.total_size <= 100_000 }.map(&:total_size).sum(0)}")

free_space = 70_000_000 - fs.directories.first.total_size
missing_space = 30_000_000 - free_space
dir_to_del = fs.directories.filter { |d| d.total_size >= missing_space }.min_by(&:total_size)
puts("Part B: #{dir_to_del}")
