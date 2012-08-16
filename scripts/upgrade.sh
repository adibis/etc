#!/bin/sh

SCRIPT_DIRECTORY=$(cd `dirname $0` && pwd)
ROOT_DIRECTORY="$(dirname "$SCRIPT_DIRECTORY")"
CURRENT_PATH=`pwd`

printf '\033[0;34m%s\033[0m\n' "Upgrading the repository"
cd $ROOT_DIRECTORY

if git pull origin master 2> /dev/null
then
  printf '\033[0;32m%s\033[0m\n' '         __           '
  printf '\033[0;32m%s\033[0m\n' '   _____/  |_  ____   '
  printf '\033[0;32m%s\033[0m\n' ' _/ __ \   __\/ ___\  '
  printf '\033[0;32m%s\033[0m\n' ' \  ___/|  | \  \___  '
  printf '\033[0;32m%s\033[0m\n' '  \___  >__|  \___  > '
  printf '\033[0;32m%s\033[0m\n' '      \/          \/  '
  printf '\033[0;32m%s\033[0m\n' '                      '
  printf '\033[0;34m%s\033[0m\n' 'Hooray! The repository has been updated to the latest available version.'
else
  printf '\033[0;31m%s\033[0m\n' 'There was an error updating. Try again later?'
fi

cd "$CURRENT_PATH"

