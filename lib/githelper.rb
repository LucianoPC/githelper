require "githelper/version"

module Githelper
  module_function

  def check_branch(branch, base_branch)
    branch_commits = Githelper.get_branch_commits(branch)
    base_branch_commits = Githelper.get_branch_commits(base_branch)

    unless branch_commits.include?(base_branch_commits.first)
      puts "Need rebase"
    end
  end

  def get_branch_commits(branch)
    commits = `git log master`.split("\n")
    commits = commits.collect{|line| line.scan(/commit (.*)/).flatten}
    commits = commits.select{|line| !line.empty?}
    return commits
  end
end
