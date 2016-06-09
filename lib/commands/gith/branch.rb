require 'command'
require 'commands/gith'
require 'commands/gith/branch/status'
require 'commands/gith/branch/merged'

# Command 'gith branch' implementation
class Branch < Command
  def self.options_messages
    %(  branch \t $ gith branch
  \t\t - Use for check your branchs
    )
  end

  def self.command_name
    'branch'
  end

  def self.run(argv)
    self.run_childrens(argv)
  end

  def self.parent
    Gith
  end

  def self.childrens
    [Status, Merged]
  end
end
