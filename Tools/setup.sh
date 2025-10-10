#!/bin/bash
set -e

YELLOW="\033[1;33m"
GREEN="\033[1;32m"
RESET="\033[0m"
REQUIRED_RUBY="3.3.4"  # match GitHub Pages

echo -e "${YELLOW}==> Detecting platform...${RESET}"

# Compare version helpers
version_lt() { test "$(printf '%s\n' "$@" | sort -V | head -n 1)" != "$1"; }
version_gt() { test "$(printf '%s\n' "$@" | sort -V | tail -n 1)" != "$1"; }

if [[ "$OSTYPE" == "darwin"* ]]; then
    echo -e "${YELLOW}macOS detected${RESET}"
    if ! command -v brew &>/dev/null; then
        echo "Homebrew not found. Installing..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi

    INSTALLED_RUBY=$(ruby -v 2>/dev/null | awk '{print $2}' || echo "0")
    if [[ "$INSTALLED_RUBY" != "$REQUIRED_RUBY" ]]; then
        echo -e "${YELLOW}Installing Ruby $REQUIRED_RUBY via Homebrew...${RESET}"
        brew install ruby@3.3
    fi
    export PATH="/opt/homebrew/opt/ruby@3.3/bin:$PATH"

else
    echo -e "${YELLOW}Linux/WSL detected${RESET}"
    sudo apt update -y
    sudo apt install -y curl git build-essential zlib1g-dev libssl-dev libreadline-dev libyaml-dev

    INSTALLED_RUBY=$(ruby -v 2>/dev/null | awk '{print $2}' || echo "0")
    if [[ "$INSTALLED_RUBY" != "$REQUIRED_RUBY" ]]; then
        echo -e "${YELLOW}Installing Ruby $REQUIRED_RUBY via rbenv...${RESET}"
        # Install rbenv only if missing
        if [ ! -d "$HOME/.rbenv" ]; then
            git clone https://github.com/rbenv/rbenv.git ~/.rbenv
            cd ~/.rbenv && src/configure && make -C src
        else
            echo "rbenv already installed, skipping clone"
        fi
        export PATH="$HOME/.rbenv/bin:$PATH"
        eval "$(rbenv init -)"

        # Install ruby-build plugin if missing
        if [ ! -d "$HOME/.rbenv/plugins/ruby-build" ]; then
            git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
        fi

        # Install requested Ruby
        rbenv install -s $REQUIRED_RUBY
        rbenv global $REQUIRED_RUBY
    fi
fi

# Verify Ruby version
RUBY_VERSION=$(ruby -v | awk '{print $2}')
if [[ "$RUBY_VERSION" != "$REQUIRED_RUBY" ]]; then
    echo "❌ Ruby version $REQUIRED_RUBY required, found $RUBY_VERSION"
    exit 1
fi
echo -e "${GREEN}Ruby $RUBY_VERSION ready${RESET}"

# --- GEM PATH CONFIG ---
if ! grep -q 'export GEM_HOME=' ~/.bashrc 2>/dev/null && ! grep -q 'export GEM_HOME=' ~/.zshrc 2>/dev/null; then
    echo -e "${YELLOW}Setting up GEM_HOME in shell config...${RESET}"
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
    echo -e "${YELLOW}Installing bundler...${RESET}"
    gem install bundler --no-document
fi

# --- GEMFILE CREATION ---
if [ ! -f "Gemfile" ]; then
    echo -e "${YELLOW}Creating Gemfile...${RESET}"
    cat <<EOF > Gemfile
source "https://rubygems.org"
gem "github-pages", group: :jekyll_plugins
EOF
fi

# --- INSTALL GEMS ---
echo -e "${YELLOW}Installing gems...${RESET}"
bundle install

echo -e "${GREEN}==> Setup complete!${RESET}"
echo -e "Run ${YELLOW}make serve${RESET} to start the local site."
