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
  end
end
