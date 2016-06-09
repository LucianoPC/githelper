require 'command'
require 'commands/gith/branch'

require 'githelper'

# Command 'gith branch merged' implementation
class Merged < Command
  def self.options_messages
    %(  merged \t $ gith branch merged
  \t\t - Show all branchs that was merged on base_branch

  \t\t $ gith branch merged [base_branch]
  \t\t - Show all branchs that was merged on specified base_branch
    )
  end

  def self.command_name
    'merged'
  end

  def self.parent
    Branch
  end

  def self.childrens
    []
  end

  def self.run(argv)
    base_branch_name = 'master' if ARGV.count < 4
    base_branch_name ||= ARGV[3]

    merged_branchs = Githelper.all_merged(base_branch_name)
    merged_branchs.each { |branch_name| puts branch_name }
  end
end


