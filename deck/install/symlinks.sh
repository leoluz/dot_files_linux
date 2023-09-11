#! /usr/bin/env sh
set -euo pipefail

current_script_dir() {
    SOURCE=${BASH_SOURCE[0]}
    while [ -L "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
      DIR=$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )
      SOURCE=$(readlink "$SOURCE")
      [[ $SOURCE != /* ]] && SOURCE=$DIR/$SOURCE # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
    done
    echo $( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )
}

########
# script

script_dir=$(current_script_dir)
git_root=$(cd "$script_dir" && git rev-parse --show-toplevel)
rm /home/deck/bin/install-1p-ext
ln -s "$git_root/deck/sysext/1password/install" /home/deck/bin/install-1p-ext
