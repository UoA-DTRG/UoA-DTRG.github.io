#!/bin/bash
set -e

# Load Ruby 3.3 environment if present
if [ -f ".ruby_env" ]; then
  # Only allow lines that are simple export statements (export VAR=VALUE)
  while IFS= read -r line; do
    if [[ "$line" =~ ^export[[:space:]]+[A-Za-z_][A-Za-z0-9_]*= ]]; then
      eval "$line"
    fi
  done < .ruby_env
fi

export GEM_HOME="$HOME/gems"
export PATH="$HOME/gems/bin:$PATH"

echo "Using Ruby version: $(ruby -v)"
echo "Starting local Jekyll server..."
bundle exec jekyll serve --livereload