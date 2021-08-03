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

  n
  node
  python
  rbenv
  ruby-build

  asdf
  elixir

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

. $(brew --prefix asdf)/asdf.sh

echo "===> Installing ASDF plugins..."]
asdf plugin-add erlang
asdf plugin-add elixir
asdf plugin-add nodejs

~/.asdf/plugins/nodejs/bin/import-release-team-keyring
echo "===> Grabbing latest Node..."
asdf install nodejs latest
asdf global nodejs latest
asdf reshim

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
mkdir -p ~/.vim/autoload ~/.vim/bundle && \
curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
echo "Remember to type leader + I to install tmux plugins"

echo "===> Installing brew cask..."
brew tap homebrew/cask

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
brew tap homebrew/cask-fonts

fonts=(
  font-fira-code
)

brew install ${fonts[@]}

echo "===> Setting up OSX..."
./osx-for-hackers.sh

echo "===> Cloning dotfile config..."
git clone git@github.com:markalfred/dotfiles ~/Repos/dotfiles

echo "===> Symlinking config files..."
~/Repos/dotfiles/create_symlinks.sh

echo "===> Setting fish as your shell..."
sudo sh -c "echo '/usr/local/bin/fish' >> /etc/shells"
chsh -s /usr/local/bin/fish

echo "===> Be sure to set fish color settings with..."
echo "fish_config"

echo "Done. Reboot, imo."
