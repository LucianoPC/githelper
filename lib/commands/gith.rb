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

  def self.parent
    nil
  end

  def self.childrens
    [Branch]
  end
end
