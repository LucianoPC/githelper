require 'command'
require 'commands/gith/branch'

# Command 'gith' implementation
class Gith < Command
  def self.options_messages
    ''
  end

  def self.command_name
    'gith'
  end

  def self.run(argv)
    argv.unshift(self.command_name)
    self.run_childrens(argv)
  end

  def self.parent
    nil
  end

  def self.childrens
    [Branch]
  end
end
