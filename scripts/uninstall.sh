#!/bin/sh

# Simple uninstall script. It deletes the etc directory.
# TODO - it should also remove all the symlinks that it generates.

echo "Removing ~/.etc"
if [ -d $HOME/.etc ]
then
  rm -rf $HOME/.etc
fi

echo "Thanks for trying out etc. It's been uninstalled."

