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
  hub
  tig
  n
  node
  python
  rbenv
  ruby-build
  tmux
  reattach-to-user-namespace
)

echo "===> Installing brew binaries..."
brew install ${brewbins[@]}

echo "===> Grabbing latest Node..."
n latest
npm install -g npm

npmbins=(
  babel-eslint
  chromedriver
  coffee-script
  eslint
  eslint-plugin-react
  mocha
  nesh
  pullr
  roots
  stylus
  typescript
  webpack
)

echo "===> Installing NPM binaries..."
npm install -g ${npmbins[@]}

echo "===> Installing manual-install binaries..."
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

echo "===> Installing brew cask..."
brew install caskroom/cask/brew-cask
brew tap caskroom/versions

apps=(
  avocode
  dash
  dropbox
  firefox
  flux
  google-chrome
  iterm2
  postgres
  sketch
  slack
  slate
  spotify
  sublime-text3
  torbrowser
  transmit
  vlc
  zeplin
)

echo "===> Cask installing apps..."
brew cask install --appdir="/Applications" ${apps[@]}

echo "===> Installing fonts..."
brew tap caskroom/fonts

fonts=(
  font-anonymous-pro
  font-cousine
  font-lekton
)

brew cask install ${fonts[@]}

echo "===> Setting up OSX..."
./osx-for-hackers.sh

echo "===> Cloning dotfile config..."
hub clone markalfred/dotfiles ~/Repos/dotfiles

echo "===> Symlinking config files..."
~/Repos/dotfiles/create_symlinks.sh

echo "===> Setting fish as your shell..."
sudo sh -c "echo '/usr/local/bin/fish' >> /etc/shells"
chsh -s /usr/local/bin/fish

echo "===> Paste package control install into Sublime console..."
open "https://packagecontrol.io/installation"
subl

echo "Done. Reboot, imo."
