#!/bin/sh

mkdir ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/rye
rye self completion -s zsh > ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/rye/_rye

git clone https://github.com/fdellwing/zsh-bat.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-bat
git clone https://github.com/djui/alias-tips.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/alias-tips
git clone https://github.com/peterhurford/git-it-on.zsh ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/git-it-on
echo "plugins+=(git-it-on)" >> ~/.zshrc
git clone https://github.com/supercrabtree/k ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/k
echo "plugins+=(k)" >> ~/.zshrc
git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git \
  ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/fast-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions
git clone https://github.com/zsh-users/zsh-history-substring-search ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-history-substring-search

echo "Don't forget to setup fzf with sh \"\$(brew --prefix fzf)/install\""
