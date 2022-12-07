require './elf_file_system'
puts '~>>~~ Welcome to AOC 2022 Day7 Elf FTP ~~<<~'
puts 'Available commands: ls, cd, quit'

file_lines = File.readlines('input.txt')
fs = ElfFileSystem.new(file_lines)
fs.reset_dir!
print "elftp:://#{fs.curr_dir_path} "
inp = gets.chomp
while inp != 'quit'
  fs.read_command(inp)
  puts "\n"
  print "elftp:://#{fs.curr_dir_path} "
  inp = gets.chomp
end

puts '~>>~~ Happy Holidays and AOC Solving ~~<<~'
