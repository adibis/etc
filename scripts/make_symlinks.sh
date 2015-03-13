#!/bin/sh

# Install script to create symlinks for all the components from this repository.

SCRIPT_DIRECTORY=$(cd `dirname $0` && pwd)
ROOT_DIRECTORY="$HOME/.etc"

printf "\033[0;33m"'\nThe script will now try to create symlinks for all the components.'"\033[0m"
printf "\033[0;33m"'\nPlease answer the following questions.\n'"\033[0m"

printf "\033[0;34m"'\nDo you want to install zsh configuration? (Y/N) (yes)'"\033[0m"
read line
if [ "$line" = Y ] || [ "$line" = y ] || [ "$line" = "" ]; then

  printf "\033[0;32m"'\nBacking up the current config files.\n'"\033[0m"
  if [ ! -f $HOME/.zshrc.pre-etc ]
  then
    mv -v $HOME/.zshrc $HOME/.zshrc.pre-etc 2> /dev/null
  else
    rm -rvf $HOME/.zshrc
  fi

  if [ ! -d $HOME/.alias.d.pre-etc ]
  then
    mv -v $HOME/.alias.d $HOME/.alias.d.pre-etc 2> /dev/null
  else
    rm -rvf $HOME/.alias.d
  fi

  if [ ! -d $HOME/.function.d.pre-etc ]
  then
    mv -v $HOME/.function.d $HOME/.function.d.pre-etc 2> /dev/null
  else
    rm -rvf $HOME/.function.d
  fi

  printf "\033[0;32m"'\nInstalling new config files.\n'"\033[0m"
  ln -sv $ROOT_DIRECTORY/zsh/zshrc $HOME/.zshrc
  ln -sv $ROOT_DIRECTORY/zsh/alias.d $HOME/.alias.d
  ln -sv $ROOT_DIRECTORY/zsh/function.d $HOME/.function.d

  if [ ! -d $HOME/.oh-my-zsh ]
  then
    printf "\033[0;34m"'\nDo you want to install oh-my-zsh? (Y/N) (yes)'"\033[0m"
    read line
    if [ "$line" = Y ] || [ "$line" = y ] || [ "$line" = "" ]; then
      git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
    fi
  fi

  if [ -d $ZSH ]
  then
    printf "\033[0;34m"'\nDo you want to install fish-shell style highlighting? (Y/N) (yes)'"\033[0m"
    read line
    if [ "$line" = Y ] || [ "$line" = y ] || [ "$line" = "" ]; then
      mkdir -p $ZSH/custom/plugins
      git clone git://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH/custom/plugins/
    fi
  fi
fi


printf "\033[0;34m"'\nDo you want to install git configuration? (Y/N) (yes)'"\033[0m"
read line
if [ "$line" = Y ] || [ "$line" = y ] || [ "$line" = "" ]; then

  printf "\033[0;32m"'\nBacking up the current config files.\n'"\033[0m"
  if [ ! -f $HOME/.gitconfig.pre-etc ]
  then
    mv -v $HOME/.gitconfig $HOME/.gitconfig.pre-etc 2> /dev/null
  else
    rm -rvf $HOME/.gitconfig
  fi

  printf "\033[0;32m"'\nInstalling new config files.\n'"\033[0m"
  ln -sv $ROOT_DIRECTORY/git/gitconfig $HOME/.gitconfig

fi

printf "\033[0;34m"'\nDo you want to install tmux configuration? (Y/N) (yes)'"\033[0m"
read line
if [ "$line" = Y ] || [ "$line" = y ] || [ "$line" = "" ]; then

  printf "\033[0;32m"'\nBacking up the current config files.\n'"\033[0m"
  if [ ! -f $HOME/.tmux.conf.pre-etc ]
  then
    mv -v $HOME/.tmux.conf $HOME/.tmux.conf.pre-etc 2> /dev/null
  else
    rm -rvf $HOME/.tmux.conf
  fi

  printf "\033[0;32m"'\nInstalling new config files.\n'"\033[0m"
  ln -sv $ROOT_DIRECTORY/tmux/tmux.conf $HOME/.tmux.conf

fi

printf "\033[0;34m"'\nDo you want to install Xresources file? (Y/N) (yes)'"\033[0m"
read line
if [ "$line" = Y ] || [ "$line" = y ] || [ "$line" = "" ]; then

  printf "\033[0;32m"'\nBacking up the current config files.\n'"\033[0m"
  if [ ! -f $HOME/.Xresources.pre-etc ]
  then
    mv -v $HOME/.Xresources $HOME/.Xresources.pre-etc 2> /dev/null
  else
    rm -rvf $HOME/.Xresources
  fi
  if [ ! -f $HOME/.Xdefaults.pre-etc ]
  then
    mv -v $HOME/.Xdefaults $HOME/.Xdefaults.pre-etc 2> /dev/null
  else
    rm -rvf $HOME/.Xdefaults
  fi

  printf "\033[0;32m"'\nInstalling new config files.\n'"\033[0m"
  ln -sv $ROOT_DIRECTORY/X/Xresources $HOME/.Xresources
  ln -sv $ROOT_DIRECTORY/X/Xresources $HOME/.Xdefaults

fi
