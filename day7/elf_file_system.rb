require './elf_directory'

class ElfFileSystem
  attr_reader :tree, :dir_path, :directories, :current_directory

  def initialize(command_lines)
    @current_directory = ElfDirectory.new('/')
    @directories = [@current_directory]
    @dir_path = [@current_directory]
    build_tree(command_lines.reverse)
  end

  def build_tree(command_lines)
    @tree = {}
    while command_lines.any?
      curr_cmd = command_lines.pop
      case curr_cmd.strip
      when /\A\$ cd .*/
        change_dir curr_cmd.split[2]
      when '$ ls'
        list_dir(command_lines)
      end
    end
  end

  def change_dir(arg)
    case arg.strip
    when '/'
      @dir_path = [@dir_path.first]
    when '..'
      @dir_path.pop
    else
      @dir_path << @current_directory.open_directory(arg)
    end
    @current_directory = @dir_path.last
  end

  def list_dir(command_lines)
    while command_lines.any? && command_lines.last.chars.first != '$'
      curr_cmd = command_lines.pop
      parts = curr_cmd.split
      if parts[0] == 'dir'
        cur = @current_directory.open_directory(parts[1])
        @directories << cur
      else
        @current_directory.add_file(parts[1], parts[0])
      end
    end
  end
end
