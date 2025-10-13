#!/bin/bash
set -e

# Determine project root
# Assumes that this script will always be in a path that looks like PROJECT_ROOT/TOOLS_DIR/THIS_SCRIPT.sh
PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# Safely load .ruby_env from project root if it exists
RUBY_ENV_FILE="$PROJECT_ROOT/.ruby_env"
if [ -f "$RUBY_ENV_FILE" ]; then
  echo "Loading Ruby environment from $RUBY_ENV_FILE..."
  while IFS= read -r line; do
    # Only allow simple export statements (export VAR=VALUE)
    if [[ "$line" =~ ^export[[:space:]]+[A-Za-z_][A-Za-z0-9_]*= ]]; then
      eval "$line"
    else
      echo "Skipping unsafe line in .ruby_env: $line"
    fi
  done < "$RUBY_ENV_FILE"
fi

export GEM_HOME="$HOME/gems"
export PATH="$HOME/gems/bin:$PATH"

echo "Using Ruby version: $(ruby -v)"
echo "Starting local Jekyll server..."
bundle exec jekyll serve --livereload