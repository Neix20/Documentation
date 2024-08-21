
# How to create new Branch
git checkout -b tmp

# Delete Branch
git branch -d tmp

# How to completely copy local branch
git switch -c tmp

# How to Move Head of Branch Head to a Commit (e.g. tmp)
git checkout tmp
git reset --soft <commit-id>

# How to Choose Specific Commits
git rebase -i HEAD~<any-number>
git rebase -i HEAD~6

# Another Way of Doing This
git checkout tmp
git cherry-pick <commit-id>
git cherry-pick <commit-id>

# Another 2 way of doing this
git checkout tmp
git rebase -i <commid-id> master
git rebase -i ecb82d40dfdff29e2515d602078242b19bdb3797 master

# Git Squash Commits
git reset --soft HEAD~3
git commit
