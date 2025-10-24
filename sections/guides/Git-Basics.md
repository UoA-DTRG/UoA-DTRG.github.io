---
title: Git Basics
layout: default
parent: Guides
nav_order: 7
---

# Git Basics for DTRG

Git is a version control system that helps track changes to code and collaborate with team members. All DTRG projects use Git repositories under the UoA-DTRG GitHub organization.

## Why Use Version Control?

- **Track Changes**: See what changed, when, and by whom
- **Collaboration**: Multiple people can work on the same project
- **Backup**: Your code is safely stored remotely
- **Experimentation**: Try new ideas without breaking working code
- **History**: Revert to previous versions if needed

## DTRG Git Conventions

### Repository Naming
- **Project Repositories**: Named after the project (e.g., `flame-thrower-drone`, `swarm-navigation`)
- **Working on Existing Code**: Use branches or forks, don't create new repositories

### Branch Naming
**Format**: `Name/Project-Title`

**Examples**:
- `John/Horizontal-Thrust`
- `Sarah/Vision-System`
- `Mike/Battery-Testing`

**Why**: This makes it easy to see who is working on what and keeps branches organized.

### Best Practices
- Commit often with meaningful messages
- Pull before you push
- Don't commit large binary files (use Teams Drive instead)
- Keep your branch up to date with main
- Test before pushing to main
- Document your code and changes

## Getting Started with Git

### Installing Git

**Windows**:
1. Download from [git-scm.com](https://git-scm.com/)
2. Run installer with default options
3. Use Git Bash or integrate with your IDE

**Linux (Ubuntu/WSL)**:
```bash
sudo apt update
sudo apt install git
```

**Mac**:
```bash
brew install git
```

### Initial Configuration

Set up your identity (use your university email):
```bash
git config --global user.name "Your Name"
git config --global user.email "your.email@auckland.ac.nz"
```

### Getting Repository Access

1. Contact your supervisor to be added to the relevant repository
2. You'll receive an invitation to the UoA-DTRG organization
3. Accept the invitation via email or GitHub

## Basic Git Workflow

### 1. Clone a Repository

Get a copy of the repository on your computer:
```bash
git clone https://github.com/UoA-DTRG/repository-name.git
cd repository-name
```

### 2. Create a Branch

Always work on a branch, not directly on main:
```bash
git checkout -b YourName/Your-Project-Title
```

### 3. Make Changes

Edit files, write code, add documentation...

### 4. Check Status

See what files you've changed:
```bash
git status
```

### 5. Stage Changes

Add files you want to commit:
```bash
# Add specific files
git add filename.py

# Add all changed files
git add .
```

### 6. Commit Changes

Save your changes with a descriptive message:
```bash
git commit -m "Add horizontal thrust control algorithm"
```

**Good commit messages**:
- `feat: add battery voltage monitoring`
- `fix: correct PID tuning for altitude hold`
- `docs: update README with setup instructions`
- `test: add unit tests for navigation module`

**Bad commit messages**:
- `stuff`
- `changes`
- `asdf`
- `update`

### 7. Push to GitHub

Upload your changes to GitHub:
```bash
# First time pushing this branch
git push -u origin YourName/Your-Project-Title

# Subsequent pushes
git push
```

### 8. Pull Latest Changes

Get the latest changes from GitHub:
```bash
# Update your current branch
git pull

# Update main branch
git checkout main
git pull
```

### 9. Merge or Pull Request

When your work is ready to merge into main:

**Option A: Pull Request (Recommended for team projects)**
1. Push your branch to GitHub
2. Go to the repository on GitHub
3. Click "Pull Request"
4. Describe your changes
5. Request review from team members or supervisor
6. Merge after approval

**Option B: Direct Merge (Use with caution)**
```bash
git checkout main
git pull
git merge YourName/Your-Project-Title
git push
```

## Common Git Commands

### Checking Your Work
```bash
git status              # See what's changed
git log                 # View commit history
git log --oneline       # Compact commit history
git diff                # See exact changes
git diff filename       # See changes in specific file
```

### Branch Management
```bash
git branch                          # List local branches
git branch -a                       # List all branches (including remote)
git checkout branch-name            # Switch to a branch
git checkout -b new-branch-name     # Create and switch to new branch
git branch -d branch-name           # Delete a branch (safe)
git branch -D branch-name           # Force delete a branch
```

### Undoing Changes
```bash
git checkout -- filename            # Discard changes to a file
git reset HEAD filename             # Unstage a file
git reset --hard                    # Discard ALL local changes (DANGEROUS)
git revert commit-hash              # Undo a specific commit
```

### Syncing with Remote
```bash
git fetch                           # Download latest from GitHub (doesn't merge)
git pull                            # Fetch and merge
git push                            # Upload your commits
git push -f                         # Force push (DANGEROUS - avoid unless necessary)
```

## Working with Existing Projects

### If the Project Has a Base Repository

**Option 1: Create a Branch (Preferred)**
```bash
git clone https://github.com/UoA-DTRG/base-project.git
cd base-project
git checkout -b YourName/Your-Project-Title
# Make your changes
git push -u origin YourName/Your-Project-Title
```

**Option 2: Fork the Repository**
1. Click "Fork" on GitHub
2. Clone your fork
3. Make changes
4. Submit pull request to original repository

### Keeping Your Branch Updated

Regularly update your branch with changes from main:
```bash
git checkout main
git pull
git checkout YourName/Your-Project-Title
git merge main
```

Or use rebase for a cleaner history:
```bash
git checkout YourName/Your-Project-Title
git rebase main
```

## What NOT to Commit

### Large Files
- Video recordings
- Large datasets (>50 MB)
- Compiled binaries
- Flight logs (store in Teams Drive)

### Sensitive Information
- Passwords or API keys
- Personal information
- Proprietary code from third parties

### Generated Files
- Build outputs
- Compiled code (unless necessary)
- IDE-specific files
- Temporary files

### Use .gitignore

Create a `.gitignore` file to automatically exclude certain files:
```
# Build outputs
build/
dist/
*.o
*.pyc

# IDE files
.vscode/
.idea/
*.swp

# OS files
.DS_Store
Thumbs.db

# Large data files
*.mp4
*.avi
data/*.csv
```

## Troubleshooting Common Issues

### "Permission Denied" When Pushing
- Make sure you've been added to the DTRG organization
- Check that you're using the correct GitHub account
- Set up SSH keys or use HTTPS with credentials

### Merge Conflicts
When Git can't automatically merge changes:
```bash
# Edit the conflicting files to resolve conflicts
# Look for markers like <<<<<<< HEAD
git add resolved-file.py
git commit -m "Resolve merge conflict"
```

### Accidentally Committed to Main
```bash
# Create a new branch from current state
git branch YourName/Your-Project-Title

# Reset main to previous state
git checkout main
git reset --hard origin/main
```

### Committed Wrong Files
```bash
# If you haven't pushed yet
git reset HEAD~1                    # Undo last commit, keep changes
git reset --hard HEAD~1             # Undo last commit, discard changes
```

### Need to Undo a Push
```bash
# Create a new commit that undoes changes
git revert commit-hash
git push
```

## GUI Tools (Optional)

Some people prefer graphical interfaces:

- **GitHub Desktop**: Simple, beginner-friendly
- **GitKraken**: Powerful, visual workflow
- **VS Code**: Built-in Git support
- **JetBrains IDEs**: Integrated Git tools

## Learning Resources

### Online Tutorials
- [GitHub Git Handbook](https://guides.github.com/introduction/git-handbook/)
- [Atlassian Git Tutorials](https://www.atlassian.com/git/tutorials)
- [Git Immersion](https://gitimmersion.com/)
- [Learn Git Branching](https://learngitbranching.js.org/) - Interactive visual tutorial

### Quick Reference
- [Git Cheat Sheet](https://education.github.com/git-cheat-sheet-education.pdf)
- [Visual Git Cheat Sheet](https://ndpsoftware.com/git-cheatsheet.html)

### Video Tutorials
- [Git and GitHub for Beginners - freeCodeCamp](https://www.youtube.com/watch?v=RGOj5yH7evk)
- [Git Tutorial for Beginners - Programming with Mosh](https://www.youtube.com/watch?v=8JJ101D3knE)

## Getting Help

### Within DTRG
- Ask experienced team members at socials
- Check with your supervisor
- Look at existing DTRG repositories for examples

### Online
- GitHub documentation
- Stack Overflow
- Git official documentation

### Emergency
If you're stuck and worried about losing work:
1. **Don't panic**
2. **Don't force push** (`git push -f`)
3. **Make a backup** (copy the entire project folder)
4. **Ask for help** in the WhatsApp group or from supervisor

## Best Practices Summary

✅ **DO**:
- Commit often with clear messages
- Pull before you push
- Use branches for your work
- Follow naming conventions
- Test before pushing to main
- Ask for help when stuck

❌ **DON'T**:
- Commit directly to main (without approval)
- Commit large binary files
- Use vague commit messages
- Force push to shared branches
- Ignore merge conflicts
- Commit sensitive information

## Related Pages
- [Getting Started](Getting-Started)
- [Project Template](Project-Template)
- [PX4 Development](../PX4/PX4-GettingStarted)

