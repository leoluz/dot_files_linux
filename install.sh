#! /usr/bin/env sh

current_script_dir() {
    SOURCE=${BASH_SOURCE[0]}
    while [ -L "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
      DIR=$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )
      SOURCE=$(readlink "$SOURCE")
      [[ $SOURCE != /* ]] && SOURCE=$DIR/$SOURCE # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
    done
    echo $( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )
}
script_dir=$(current_script_dir)

# Kitty setup
kitty_cfgdir="$HOME/.config/kitty"
mkdir -p $kitty_cfgdir
[ ! -L $kitty_cfgdir/kitty.conf ] && ln -s $script_dir/kitty.conf $kitty_cfgdir/kitty.conf
[ ! -d $kitty_cfgdir/kitty-themes ] && git clone --depth 1 https://github.com/dexpota/kitty-themes.git $kitty_cfgdir/kitty-themes
[ ! -d $kitty_cfgdir/kittens ] && mkdir $kitty_cfgdir/kittens && ln -s $script_dir/kitty/kittens/zoom_toggle.py $kitty_cfgdir/kittens/zoom_toggle.py
[ ! -L $kitty_cfgdir/theme.conf ] && ln -s $script_dir/kitty/themes/one-dark.conf $kitty_cfgdir/theme.conf
[ ! -L $kitty_cfgdir/session.conf ] && ln -s $script_dir/kitty/session.conf $kitty_cfgdir/session.conf

# Oh-my-zsh setup
if [ ! -d "$HOME/.oh-my-zsh" ]; then
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# FZF
if [ ! -d "$HOME/.fzf" ]; then
	git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
	~/.fzf/install
fi

# Misc setup
[ ! -f $HOME/.zshrc ] && ln -s $script_dir/zshrc $HOME/.zshrc
[ ! -f $HOME/.gitconfig ] && ln -s $script_dir/gitconfig $HOME/.gitconfig
