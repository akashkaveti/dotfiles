#!/usr/bin/env bash

# install homebrew if needed
if ! which brew ; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  # For Mac M2 and M3
  (echo; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> ~/.zprofile
  eval "$(/opt/homebrew/bin/brew shellenv)"

  # we don't have the Brewfile cloned - yet. so ... wait.
else
  echo "Skipping homebrew installation. Seems to be installed."
fi

# clone the repo if not yet done ;)
if [ ! -d "$HOME/.dotfiles" ] ; then
  cd "$HOME"
  # now we *definitively* have git ...
  git clone https://github.com/akashkaveti/dotfiles.git .dotfiles
fi

# NOW we have the brewfile :) . use it.
brew bundle --file=$HOME/.dotfiles/Brewfile

# install virtualenvwrapper for the oh-my-zsh plugin
pip3 install virtualenvwrapper

# continue with generic items
echo -e "\n\n * Installing zsh manager(s) ..."
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"


# for auto suggestions
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh