#! /usr/bin/env sh

script_dir=$(dirname $(python -c "import os; import sys; print(os.path.realpath(sys.argv[1]))" "$0"))

# Kitty setup
kitty_cfgdir="$HOME/.config/kitty"
mkdir -p $kitty_cfgdir
[ ! -L $kitty_cfgdir/kitty.conf ] && ln -s $script_dir/kitty.conf $kitty_cfgdir/kitty.conf
[ ! -d $kitty_cfgdir/kitty-themes ] && git clone --depth 1 https://github.com/dexpota/kitty-themes.git $kitty_cfgdir/kitty-themes
[ ! -d $kitty_cfgdir/kittens ] && mkdir $kitty_cfgdir/kittens && ln -s $script_dir/kitty/kittens/zoom_toggle.py $kitty_cfgdir/kittens/zoom_toggle.py
[ ! -L $kitty_cfgdir/wallpaper.png ] && ln -s $script_dir/wallpaper/eva.png $kitty_cfgdir/wallpaper.png
[ ! -L $kitty_cfgdir/theme.conf ] && ln -s $script_dir/kitty/catppuccin-mocha.conf $kitty_cfgdir/theme.conf
[ ! -L $kitty_cfgdir/session.conf ] && ln -s $script_dir/kitty/session.conf $kitty_cfgdir/session.conf

# Oh-my-zsh setup
#ohmyzsh_cfgdir="$HOME/.oh-my-zsh"
#[ ! -d $ohmyzsh_cfgdir ] && git clone git@github.com:ohmyzsh/ohmyzsh.git $ohmyzsh_cfgdir

# Misc setup
#[ ! -f $HOME/.ad_profile ] && ln -s $script_dir/ad_profile $HOME/.ad_profile
#[ ! -f $HOME/.dw_profile ] && ln -s $script_dir/dw_profile $HOME/.dw_profile
#[ ! -f $HOME/.it_profile ] && ln -s $script_dir/it_profile $HOME/.it_profile
[ ! -f $HOME/.zshrc ] && ln -s $script_dir/zshrc $HOME/.zshrc
[ ! -f $HOME/.gitconfig ] && ln -s $script_dir/gitconfig $HOME/.gitconfig
#[ ! -f $HOME/.bash_profile ] && ln -s $script_dir/bash_profile $HOME/.bash_profile
