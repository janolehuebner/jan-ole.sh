#!/usr/bin/env bash

if [[ -z "$HOSTNAME" ]]; then
  export HOSTNAME=$(hostname)
fi

detect_os() {
    case "$OSTYPE" in
        solaris*) echo "solaris" ;;
        darwin*)  echo "macos" ;;
        linux*)   echo "linux" ;;
        bsd*)     echo "bsd" ;;
        msys* | cygwin*) echo "windows" ;;
        *)        echo "unknown" ;;
    esac
}

echo "You are on $(detect_os)"
if command -v git &> /dev/null; then
    echo "Git is installed: $(git --version)"
else
    echo "Git is not installed."
    exit 1
fi

git clone -n --config core.bare=true --separate-git-dir=$HOME/.dotgit git@github.com:janolehuebner/dotfiles.git $(mktemp -d)
git --work-tree=$HOME --git-dir=$HOME/.dotgit reset HEAD
git --work-tree=$HOME --git-dir=$HOME/.dotgit switch -c $HOSTNAME
git --work-tree=$HOME --git-dir=$HOME/.dotgit -c user.name="$USER" -c user.email="${USER}@${HOSTNAME}" commit -am "Backed up pre-existing configs to local branch"
git --work-tree=$HOME --git-dir=$HOME/.dotgit checkout main
git pull
source ~/.zprofile
install_dotfiles
