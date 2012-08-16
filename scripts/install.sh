#!/bin/sh

# TODO - Get an optional directory path as an argument - create that directory and install there.

SCRIPT_DIRECTORY=$(cd `dirname $0` && pwd)
ROOT_DIRECTORY="$(dirname "$SCRIPT_DIRECTORY")"

# Proceed only if the ~/.etc directory does not exist.
if [ -d $HOME/.etc ]
then
    printf "\033[0;33mYou already have this repository installed.\033[0m You'll need to remove ~/.etc if you want to install"
    exit
fi

# Try cloning into the repository. Exit if git error.
printf "\033[0;34mCloning etc...\n\033[0m"
hash git >/dev/null && /usr/bin/env git clone https://github.com/adibis/etc.git ~/.etc || {
    printf "\ngit not installed"
    printf "\nPlease install git and try again."
    exit
}

printf "\033[0;34m\nTime to change your default shell to zsh!\n\033[0m"
if which zsh 2> /dev/null
then
    chsh -s `which zsh`
else
{
    printf "\033[0;31m"'\nzsh not installed. Large part of etc is zsh dependent.'"\033[0m"
    printf "\033[0;31m"'\nPlease install zsh if you want all the features.'"\033[0m"
}
fi

printf "\n"
printf "\033[0;33m"'                       '"\n\033[0m"
printf "\033[0;33m"'         __            '"\n\033[0m"
printf "\033[0;33m"'   _____/  |_  ____    '"\n\033[0m"
printf "\033[0;33m"' _/ __ \   __\/ ___\   '"\n\033[0m"
printf "\033[0;33m"' \  ___/|  | \  \___   '"\n\033[0m"
printf "\033[0;33m"'  \___  >__|  \___  >  '"\n\033[0m"
printf "\033[0;33m"'      \/          \/   '"\n\033[0m"
printf "\033[0;33m"'                       '"\n\033[0m"

printf "\n \033[0;33m....is now installed.\033[0m"
printf "\n\n \033[0;33m\nCreating the required symlinks.\033[0m"

sh $SCRIPT_DIRECTORY/make_symlinks.sh

