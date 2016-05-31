require 'spec_helper'

describe Githelper do
  it 'has a version number' do
    expect(Githelper::VERSION).not_to be nil
  end

  describe 'test need_rebase function' do
    it 'branch with base commits not needs rebase' do
      branch_commits = ['e', 'd', 'c', 'b', 'a']
      base_branch_commits = ['d', 'c', 'b', 'a']

      result = Githelper.need_rebase(branch_commits, base_branch_commits)
      expect(result).to be false
    end

    it 'branch with same commits of base not needs rebase' do
      branch_commits = ['e', 'd', 'c', 'b', 'a']
      base_branch_commits = ['e', 'd', 'c', 'b', 'a']

      result = Githelper.need_rebase(branch_commits, base_branch_commits)
      expect(result).to be false
    end

    it 'branch without all base commits not needs rebase' do
      branch_commits = ['e', 'c', 'b', 'a']
      base_branch_commits = ['d', 'c', 'b', 'a']

      result = Githelper.need_rebase(branch_commits, base_branch_commits)
      expect(result).to be true
    end
  end
end
