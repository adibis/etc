#!/bin/sh

# TODO - Get an optional directory path as an argument - create that directory and install there.

# Proceed only if the ~/.etc directory does not exist.
if [ -d $HOME/.etc ]
then
    echo "\033[0;33mYou already have this repository installed.\033[0m You'll need to remove ~/.etc if you want to install"
    exit
fi

# Try cloning into the repository. Exit if git error.
echo "\033[0;34mCloning etc...\033[0m"
hash git >/dev/null && /usr/bin/env git clone https://github.com/adibis/etc.git ~/.etc || {
    echo "git not installed"
    echo "Please install git and try again."
    exit
}

echo "\033[0;34mTime to change your default shell to zsh!\033[0m"
if which tcsh 2> /dev/null
then
    chsh -s `which zsh`
else
{
    echo "\033[0;31m"'zsh not installed. Large part of etc is zsh dependent.'"\033[0m"
    echo "\033[0;31m"'Please install zsh if you want all the features.'"\033[0m"
}
fi

echo "\033[0;33m"'                       '"\033[0m"
echo "\033[0;33m"'         __            '"\033[0m"
echo "\033[0;33m"'   _____/  |_  ____    '"\033[0m"
echo "\033[0;33m"' _/ __ \   __\/ ___\   '"\033[0m"
echo "\033[0;33m"' \  ___/|  | \  \___   '"\033[0m"
echo "\033[0;33m"'  \___  >__|  \___  >  '"\033[0m"
echo "\033[0;33m"'      \/          \/   '"\033[0m"
echo "\033[0;33m"'                       '"\033[0m"

echo "\n\n \033[0;33m....is now installed.\033[0m"

