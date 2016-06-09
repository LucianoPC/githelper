require 'command'
require 'commands/gith/branch'

require 'githelper'

# Command 'gith branch status' implementation
class Status < Command
  def self.usage
    'Usage: gith branch status'
  end

  def self.options_messages
    %(  status \t $ gith branch status
  \t\t - Show status of all branchs

  \t\t $ gith branch status [branch_name_1] ... [branch_name_n]
  \t\t - Show status of specified branchs
    )
  end

  def self.command_name
    'status'
  end

  def self.parent
    Branch
  end

  def self.childrens
    []
  end

  def self.run(argv)
    branch_names, base_branch_name = self.branchs_names(argv)

    branch_names.each do |branch_name|
      puts "\n" if branch_name != branch_names.first
      self.show_branch_status(branch_name, base_branch_name)
    end
  end

  def self.branchs_names(argv)
    if argv.count > 3
      branch_names = [argv[3]]
      base_branch_name = argv[4] || 'master'
    else
      base_branch_name = 'master'
      branch_names = Githelper.get_all_branchs(base_branch_name)
    end

    [branch_names, base_branch_name]
  end

  def self.show_branch_status(branch_name, base_branch_name)
    result = Githelper.check_branch(branch_name, base_branch_name)
    puts "Branch: #{branch_name}"
    if result == Githelper::BRANCH_STATUS[:need_rebase]
      puts 'Status: Need Rebase'
    elsif result == Githelper::BRANCH_STATUS[:is_merged]
      puts 'Status: Is Merged'
    elsif result == Githelper::BRANCH_STATUS[:none]
      puts 'Status: OK'
    end
    puts "With: #{base_branch_name}"
  end
end

