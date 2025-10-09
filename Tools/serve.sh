#!/bin/bash
set -e
export GEM_HOME="$HOME/gems"
export PATH="$HOME/gems/bin:$PATH"

echo "Starting local Jekyll server..."
bundle exec jekyll serve --livereload