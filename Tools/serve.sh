#!/bin/bash
set -e

# Load Ruby 3.3 environment if present
if [ -f ".ruby_env" ]; then
  source .ruby_env
fi

export GEM_HOME="$HOME/gems"
export PATH="$HOME/gems/bin:$PATH"

echo "Using Ruby version: $(ruby -v)"
echo "Starting local Jekyll server..."
bundle exec jekyll serve --livereload