#!/bin/sh

# Simple uninstall script. It deletes the etc directory.
# TODO - it should also remove all the symlinks that it generates.

SCRIPT_DIRECTORY=$(cd `dirname $0` && pwd)
ROOT_DIRECTORY="$(dirname "$SCRIPT_DIRECTORY")"

echo "Removing ~/.etc"
if [ -d $HOME/.etc ]
then
  rm -rf $HOME/.etc
fi

sh $SCRIPT_DIRECTORY/make_symlinks.sh

echo "Thanks for trying out etc. It's been uninstalled."

