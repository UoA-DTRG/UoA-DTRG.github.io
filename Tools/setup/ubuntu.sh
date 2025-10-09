#!/bin/bash
set -e

YELLOW="\033[1;33m"
GREEN="\033[1;32m"
RESET="\033[0m"

echo -e "${YELLOW}==> Checking platform...${RESET}"
if [[ "$OSTYPE" == "darwin"* ]]; then
  echo -e "${YELLOW}==> macOS detected${RESET}"
  if ! command -v brew &>/dev/null; then
    echo "Homebrew not found. Installing..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi
  brew install ruby git
else
  echo -e "${YELLOW}==> Linux/WSL detected${RESET}"
  sudo apt update -y
  sudo apt install -y ruby-full build-essential zlib1g-dev git
fi

# --- RUBY GEM PATH CONFIG ---
if ! grep -q 'export GEM_HOME=' ~/.bashrc 2>/dev/null && ! grep -q 'export GEM_HOME=' ~/.zshrc 2>/dev/null; then
  echo -e "${YELLOW}==> Adding Ruby gem path to shell config...${RESET}"
  {
    echo '# Ruby Gems installation path'
    echo 'export GEM_HOME="$HOME/gems"'
    echo 'export PATH="$HOME/gems/bin:$PATH"'
  } >> ~/.bashrc
fi

export GEM_HOME="$HOME/gems"
export PATH="$HOME/gems/bin:$PATH"

# --- INSTALL BUNDLER ---
if ! command -v bundle &>/dev/null; then
  echo -e "${YELLOW}==> Installing bundler...${RESET}"
  gem install bundler --no-document
fi

# --- GEMFILE CREATION ---
if [ ! -f "Gemfile" ]; then
  echo -e "${YELLOW}==> Creating Gemfile...${RESET}"
  cat <<EOF > Gemfile
source "https://rubygems.org"
gem "github-pages", group: :jekyll_plugins
EOF
fi

# --- INSTALL GEMS ---
echo -e "${YELLOW}==> Installing Ruby gems...${RESET}"
bundle install

echo -e "${GREEN}==> Setup complete!${RESET}"
echo -e "Run ${YELLOW}./Tools/Serve.sh${RESET} to start the local site."
