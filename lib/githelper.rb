require 'githelper/version'

# Module to help git
module Githelper
  module_function

  BRANCH_STATUS = { none: 0, need_rebase: 1 }.freeze

  def check_branch(branch_name, base_branch_name)
    branch_commits = Githelper.get_branch_commits(branch_name)
    base_branch_commits = Githelper.get_branch_commits(base_branch_name)

    if need_rebase(branch_commits, base_branch_commits)
      return BRANCH_STATUS[:need_rebase]
    end
  end

  def need_rebase(branch_commits, base_branch_commits)
    need_rebase = !branch_commits.include?(base_branch_commits.first)

    need_rebase
  end

  def get_branch_commits(branch)
    commits = `git log #{branch}`.split("\n")
    commits = commits.collect { |line| line.scan(/commit (.*)/).flatten }
    commits = commits.select { |line| !line.empty? }

    commits
  end
end
