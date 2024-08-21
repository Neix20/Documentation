
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

# Move Head Pointer
git branch -f tmp

######################
# Clean Git Commits
######################

# Checkout to New Branch
git checkout -b <branch-name>
git checkout -b tmp

# Rebase current branch to master
# Rebase as many times as needed
git rebase -i <start-commit> <end-commit>
git rebase -i <start-commit> <branch-name>
git rebase -i 80dc08e2425f21d101e5d64beec950d75d9d3511 tmp

# Once you have completed, your "squash" and "reword" rebase
# Checkout to Master
git checkout master

# Reset to Original Commit
git reset --soft <commid-id>
git reset --soft 80dc08e2425f21d101e5d64beec950d75d9d3511

# Merge With Tmp Branch
git merge tmp

# Finally, Delete the Newly Created Branch
git branch -d tmp

