require 'githelper/version'

# Module to help git
module Githelper
  module_function

  BRANCH_STATUS = [:need_rebase, :none].freeze

  def check_branch(branch, base_branch)
    branch_commits = Githelper.get_branch_commits(branch)
    base_branch_commits = Githelper.get_branch_commits(base_branch)

    if need_rebase(branch_commits, base_branch_commits)
      return BRANCH_STATUS[:need_rebase]
    end
  end

  def need_rebase(branch_commits, base_branch_commits)
    need_rebase = !base_branch_commits.include?(branch_commits.first)
    need_rebase &= !branch_commits.include?(base_branch_commits.first)

    need_rebase
  end

  def get_branch_commits(branch)
    commits = `git log #{branch}`.split("\n")
    commits = commits.collect { |line| line.scan(/commit (.*)/).flatten }
    commits = commits.select { |line| !line.empty? }

    commits
  end
end
