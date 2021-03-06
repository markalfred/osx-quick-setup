#!/bin/sh

# Set up a new computer.

set -e

echo "===> Installing Homebrew..."
command -v brew >/dev/null 2>&1 || {
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
}
brew doctor
brew update

brewbins=(
  fish
  direnv
  git
  gh
  tig
  tmux
  reattach-to-user-namespace

  node
  python
  rbenv
  ruby-build

  asdf
  elixir
  default-jdk

  awscli
  heroku

  autoconf
  automake
  coreutils
  gpg
  openssl
  readline
  watchman

  ffmpeg
  prettyping
  speedtest-cli
  terminal-notifier
)

echo "===> Installing brew binaries..."
brew install ${brewbins[@]}

echo "===> Grabbing latest Node..."
n latest
npm install -g npm

npmbins=(
  babel-eslint
  chromedriver
  eslint
  eslint-plugin-react
  mocha
  nesh
  prettier
  typescript
  webpack
)

echo "===> Installing NPM binaries..."
npm install -g ${npmbins[@]}

echo "===> Installing manual-install binaries..."
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
echo "Remember to type leader + I to install tmux plugins"

echo "===> Installing ASDF plugins..."
asdf plugin-add erlang
asdf plugin-add elixir
asdf plugin-add nodejs

~/.asdf/plugins/nodejs/bin/import-release-team-keyring
asdf install nodejs latest
asdf reshim

echo "===> Installing brew cask..."
brew install caskroom/cask/brew-cask
brew tap caskroom/versions

# apps=(
#   avocode
#   dash
#   dropbox
#   firefox
#   flux
#   google-chrome
#   iterm2
#   postgres
#   sketch
#   slack
#   slate
#   spotify
#   sublime-text3
#   torbrowser
#   transmit
#   vlc
#   zeplin
#   android-studio
#   java
# )

# echo "===> Cask installing apps..."
# brew cask install --appdir="/Applications" ${apps[@]}

echo "===> Installing fonts..."
brew tap caskroom/fonts

fonts=(
  font-anonymous-pro
  font-cousine
  font-fira-code
  font-lekton
  font-open-sans
  font-roboto
)

brew cask install ${fonts[@]}

echo "===> Setting up OSX..."
./osx-for-hackers.sh

echo "===> Cloning dotfile config..."
gh repo clone markalfred/dotfiles ~/Repos/dotfiles

echo "===> Symlinking config files..."
~/Repos/dotfiles/create_symlinks.sh

echo "===> Setting fish as your shell..."
sudo sh -c "echo '/usr/local/bin/fish' >> /etc/shells"
chsh -s /usr/local/bin/fish

echo "===> Be sure to set fish color settings with..."
echo "fish_config"

echo "Done. Reboot, imo."
