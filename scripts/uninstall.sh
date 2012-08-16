#!/bin/sh

# Simple uninstall script. It deletes the etc directory.
# TODO - it should also remove all the symlinks that it generates.

SCRIPT_DIRECTORY=$(cd `dirname $0` && pwd)
ROOT_DIRECTORY="$(dirname "$SCRIPT_DIRECTORY")"

printf "\033[0;31m"'\nRemoving ~/.etc...\n'"\033[0m"
if [ -d $HOME/.etc ]
then
  rm -rf $HOME/.etc
fi

sh $SCRIPT_DIRECTORY/remove_symlinks.sh

printf "\033[0;33m"'\n\nThanks for trying out etc. It has been uninstalled.\n'"\033[0m"

