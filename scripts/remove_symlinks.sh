#!/bin/sh

# Script to remove the symlinks created by etc and restore the backups.

SCRIPT_DIRECTORY=$(cd `dirname $0` && pwd)
ROOT_DIRECTORY="$(dirname "$SCRIPT_DIRECTORY")"

printf "\033[0;33m"'\nThe script will now remove the symlinks it created.'"\033[0m"
printf "\033[0;33m"'\nThis operation will only remove symlinks if the backup files exist.'"\033[0m"
printf "\033[0;33m"'\nPlease answer the following questions.\n'"\033[0m"

printf "\033[0;34m"'\nDo you want to uninstall zsh configuration? (Y/N) (no)'"\033[0m"
read line
if [ "$line" = Y ] || [ "$line" = y ]; then

  printf "\033[0;32m"'\nRemoving the symlinks and restoring backups.\n'"\033[0m"
  if [ -f $HOME/.zshrc.pre-etc ]
  then
    rm -rvf $HOME/.zshrc 2> /dev/null
    mv -v $HOME/.zshrc.pre-etc $HOME/.zshrc 2> /dev/null
  fi

  if [ -d $HOME/.alias.d.pre-etc ]
  then
    rm -rvf $HOME/.alias.d 2> /dev/null
    mv -v $HOME/.alias.d.pre-etc $HOME/.alias.d 2> /dev/null
  fi

  if [ -d $HOME/.function.d.pre-etc ]
  then
    rm -rvf $HOME/.function.d 2> /dev/null
    mv -v $HOME/.function.d.pre-etc $HOME/.function.d 2> /dev/null
  fi

  if [ -d $HOME/.oh-my-zsh ]
  then
    printf "\033[0;34m"'\nDo you want to uninstall oh-my-zsh? (Y/N) (no)'"\033[0m"
    read line
    if [ "$line" = Y ] || [ "$line" = y ]; then
      rm -rvf $HOME/.oh-my-zsh 2> /dev/null
    fi
  fi
fi

printf "\033[0;34m"'\nDo you want to uninstall git configuration? (Y/N) (no)'"\033[0m"
read line
if [ "$line" = Y ] || [ "$line" = y ]; then

  printf "\033[0;32m"'\nRemoving the symlinks and restoring backups.\n'"\033[0m"
  if [ -f $HOME/.gitconfig.pre-etc ]
  then
    rm -rvf $HOME/.gitconfig 2> /dev/null
    mv -v $HOME/.gitconfig.pre-etc $HOME/.gitconfig 2> /dev/null
  fi
fi

printf "\033[0;34m"'\nDo you want to uninstall tmux configuration? (Y/N) (no)'"\033[0m"
read line
if [ "$line" = Y ] || [ "$line" = y ]; then

  printf "\033[0;32m"'\nRemoving the symlinks and restoring backups.\n'"\033[0m"
  if [ -f $HOME/.tmux.conf.pre-etc ]
  then
    rm -rvf $HOME/.tmux.conf 2> /dev/null
    mv -v $HOME/.tmux.conf.pre-etc $HOME/.tmux.conf 2> /dev/null
  fi
fi

printf "\033[0;34m"'\nDo you want to uninstall Xresources file? (Y/N) (no)'"\033[0m"
read line
if [ "$line" = Y ] || [ "$line" = y ]; then

  printf "\033[0;32m"'\nRemoving the symlinks and restoring backups.\n'"\033[0m"
  if [ -f $HOME/.Xresources.pre-etc ]
  then
    rm -rvf $HOME/.Xresources 2> /dev/null
    mv -v $HOME/.Xresources.pre-etc $HOME/.Xresources 2> /dev/null
  fi
  if [ -f $HOME/.Xdefaults.pre-etc ]
  then
    rm -rvf $HOME/.Xdefaults 2> /dev/null
    mv -v $HOME/.Xdefaults.pre-etc $HOME/.Xdefaults 2> /dev/null
  fi
fi
