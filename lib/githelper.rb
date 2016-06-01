require 'githelper/version'

# Module to help git
module Githelper
  module_function

  BRANCH_STATUS = { ok: 0, need_rebase: 1, is_merged: 2 }.freeze

  def check_branch(branch_name, base_branch_name)
    branch_commits = Githelper.get_branch_commits(branch_name)
    base_branch_commits = Githelper.get_branch_commits(base_branch_name)

    if need_rebase(branch_commits, base_branch_commits)
      return BRANCH_STATUS[:need_rebase]
    elsif merged?(branch_commits, base_branch_commits)
      return BRANCH_STATUS[:is_merged]
    end
  end

  def need_rebase(branch_commits, base_branch_commits)
    need = !branch_commits.include?(base_branch_commits.first)
    need &= !base_branch_commits.include?(branch_commits.first)

    need
  end

  def merged?(branch_commits, base_branch_commits)
    branch_commits.each do |commit|
      return false unless base_branch_commits.include?(commit)
    end

    true
  end

  def get_branch_commits(branch)
    commits = `git log #{branch}`.split("\n")
    commits = commits.collect { |line| line.scan(/commit (.*)/).flatten }
    commits = commits.select { |line| !line.empty? }.flatten

    commits
  end

  def get_all_branchs(remove_branchs = [])
    remove_branchs = [remove_branchs] unless remove_branchs.is_a?(Array)
    branchs = `git branch`.split("\n")
    branchs = branchs.collect { |branch| branch.scan(/\W(.*)/).flatten }
    branchs = branchs.flatten.map(&:strip)
    branchs -= remove_branchs

    branchs
  end
end
