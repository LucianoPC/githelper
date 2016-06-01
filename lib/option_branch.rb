require 'githelper'

# module with commands to run option branch on gith
# exemple: gith branch
module OptionBranch
  module_function

  @argv = []

  def run(argv)
    @argv = argv

    branch_names, base_branch_name = branchs_names

    branch_names.each do |branch_name|
      puts "\n" if branch_name != branch_names.first
      show_branch_status(branch_name, base_branch_name)
    end
  end

  def usage
    puts 'Usage: gith branch [branch_name] [base_branch_name]'
    puts "\n by default, base_branch_name is 'master'"

    abort
  end

  def branchs_names
    if @argv.count > 1
      branch_names = [@argv[1]]
      base_branch_name = @argv[2] || 'master'
    else
      base_branch_name = 'master'
      branch_names = Githelper.get_all_branchs(base_branch_name)
    end

    [branch_names, base_branch_name]
  end

  def branch
    branch_names, base_branch_name = branchs_names

    branch_names.each do |branch_name|
      puts "\n" if branch_name != branch_names.first
      show_branch_status(branch_name, base_branch_name)
    end
  end

  def show_branch_status(branch_name, base_branch_name)
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

  def merged
    base_branch_name = 'master' if @argv.count < 2
    base_branch_name ||= @argv[1]

    merged_branchs = Githelper.all_merged(base_branch_name)
    merged_branchs.each { |branch_name| puts branch_name }
  end
end
