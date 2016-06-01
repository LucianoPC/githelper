require 'spec_helper'

describe Githelper do
  it 'has a version number' do
    expect(Githelper::VERSION).not_to be nil
  end

  describe 'test need_rebase function' do
    it 'branch without all base commits not needs rebase' do
      branch_commits = %w(e c b a)
      base_branch_commits = %w(d c b a)

      result = Githelper.need_rebase(branch_commits, base_branch_commits)
      expect(result).to be true
    end

    it 'branch with base commits not needs rebase' do
      branch_commits = %w(e d c b a)
      base_branch_commits = %w(d c b a)

      result = Githelper.need_rebase(branch_commits, base_branch_commits)
      expect(result).to be false
    end

    it 'branch with same commits of base not needs rebase' do
      branch_commits = %w(e d c b a)
      base_branch_commits = %w(e d c b a)

      result = Githelper.need_rebase(branch_commits, base_branch_commits)
      expect(result).to be false
    end

    it 'branch with all commits in base not needs rebase' do
      branch_commits = %w(e d c b a)
      base_branch_commits = %w(f e d c b a)

      result = Githelper.need_rebase(branch_commits, base_branch_commits)
      expect(result).to be false
    end
  end

  describe 'test is_merged function' do
    it 'branch have all commits in base branch is merged' do
      branch_commits = %w(e d c b a)
      base_branch_commits = %w(f e d c b a)

      result = Githelper.is_merged(branch_commits, base_branch_commits)
      expect(result).to be true
    end

    it 'base branch dont have all commits of branch is not merged' do
      branch_commits = %w(e d c b a)
      base_branch_commits = %w(f e d b a)

      result = Githelper.is_merged(branch_commits, base_branch_commits)
      expect(result).to be false
    end
  end
end
