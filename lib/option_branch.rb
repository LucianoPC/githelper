require 'githelper'

# module with commands to run option branch on gith
# exemple: gith branch
module OptionBranch
  module_function

  @argv = []

  VALID_OPTIONS = %w(status merged).freeze

  def usage
    puts 'Usage: gith branch [option]'
    puts "\n[options]\n\n"
    puts option_status
    puts option_merged
    puts " By default, base_branch is 'master'"

    abort
  end

  def option_status
    %( status \t $ gith branch status
  \t\t - Show status of all branchs

  \t\t $ gith branch status [branch_name_1] ... [branch_name_n]
  \t\t - Show status of specified branchs
    )
  end

  def option_merged
    %( merged \t $ gith merged
  \t\t - Show all branchs that was merged on base_branch

  \t\t - $ gith branch merged [base_branch]
  \t\t - Show all branchs that was merged on specified base_branch
    )
  end

  def run(argv)
    @argv = argv

    usage if @argv.size < 2 || !VALID_OPTIONS.include?(@argv[1])

    option = @argv[1]
    send(option)
  end

  def status
    branch_names, base_branch_name = branchs_names

    branch_names.each do |branch_name|
      puts "\n" if branch_name != branch_names.first
      show_branch_status(branch_name, base_branch_name)
    end
  end

  def merged
    base_branch_name = 'master' if ARGV.count < 3
    base_branch_name ||= ARGV[2]

    merged_branchs = Githelper.all_merged(base_branch_name)
    merged_branchs.each { |branch_name| puts branch_name }
  end

  def branchs_names
    if @argv.count > 2
      branch_names = [@argv[2]]
      base_branch_name = @argv[3] || 'master'
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
end
