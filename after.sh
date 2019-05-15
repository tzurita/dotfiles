#!/usr/bin/bash
#

# Move space theme to nvim themes diretory
cp nvim/space.vim /home/zuritat/.config/nvim/plugged/vim-airline-themes/autoload/airline/themes/ 

# Add Plugins for .zshrc
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# Install Nerd Fonts
font_dir="$HOME/.local/share/fonts"

if [ ! -d "$font_dir" ]
then
    mkdir -p "$font_dir"
fi

cd $font_dir
wget https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Hack/Regular/complete/Hack%20Regular%20Nerd%20Font%20Complete%20Mono.ttf
wget https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Hack/Regular/complete/Hack%20Regular%20Nerd%20Font%20Complete.ttf

# NPM - Install vtop
cd $HOME
mkdir ~/.npm-global
npm config set prefix '~/.npm-global'
npm install -g vtop

# Install Haxtor News
pip install haxor-news --user

# Install colorls
gem install colorls
