# dr_setup
Setup instructions for new system

Note: Create sub-readme's linked here for the following
- Setup mac

## Download & use iterm2 (Mac)

- Use Safari to download iterm2 ([here](https://iterm2.com/downloads.html)), double click and agree to move to applications
- Open finder and pull Applications folder to dock next to trash
- Remove everything else from doc except finder & Applications

## Install Rye

```
# Requires answering some questions
curl -sSf https://rye-up.com/get | bash

# Added shims and autocomplete
echo 'source "$HOME/.rye/env"' >> ~/.zshrc
mkdir $ZSH_CUSTOM/plugins/rye
rye self completion -s zsh > $ZSH_CUSTOM/plugins/rye/_rye

```

## Install & Setup zsh

Install:
```
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

Update theme:
```
# Copy custom theme file from github.com/drothermel/dr_setup/
# for whichever theme you want
cp dr_setup/zsh_custom_themes/af-magic.zsh-theme $ZSH_CUSTOM/themes/
```

Copy in .zshrc and setup plugins:
```
# Copy .zshrc from github/drothermel/dr_setup
cp dr_setup/dotfiles/.zshrc ~/.zshrc

# Ignore any errors here, need to activate rye
exec zsh

# Run script from github/drothermel/dr_setup
./dr_setup/zsh_plugin_setup.sh

# # IF WE DIDN't COPY .zshrc, ADD:
source $ZSH_CUSTOM/plugins/k/k.sh
source "$HOME/.rye/env"
# before export ZSH="$HOME/.oh-my-zsh
fpath+=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src

# Setup fzf by running (my answers: y, y, n) (based on this)
sh "$(brew --prefix fzf)/install"
```

## Setup Brew

Install:
```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Setup:
```
(echo; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> /Users/dev_v0/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"
```

Install & Setup Brew Apps:
```
# Use this to install brew apps from
# github.com/drothermel/dr_setup/brew_apps.txt
xargs brew install < brew_apps.txt
# github.com/drothermel/dr_setup/brew_casks.txt
xargs brew install --cask < brew_casks.txt


# More Setup
brew tap homebrew/cask-fonts
brew install font-hack-nerd-font
conda init "$(basename "${SHELL}")"

# If we didn't copy the .zhsrc then add these in
eval $(fzf --zsh)
eval $(thefuck --alias)

# either copy rest of dot files or add this to .vimrc
set rtp+=/opt/homebrew/opt/fzf
```

## Make Sure Rye Still Works & Install JupyterLab

Check your `.zhsrc` file to be sure rye is sourced last:
```
# Move this line to the end:
source "$HOME/.rye/env"
```

Then install jupyter lab globally with rye:
```
rye install jupyterlab --extra-requirement jupyterlab_vim
# added an alias to zshrc if not copied
alias jlab='jupyter-lab'
```





