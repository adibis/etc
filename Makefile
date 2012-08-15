# Makefile: Deploys links in all the right places.
# Aditya Shevade <aditya.shevade@gmail.com>

# TODO - installing MPD config.
# TODO - installing vim.
# TODO - installing oh-my-zsh.

.PHONY: all git tmux xterm zsh

all: git tmux xterm zsh

git:
	rm -rf ~/.gitconfig
	ln -s `pwd`/git/gitconfig ~/.gitconfig

tmux:
	rm -rf ~/.tmux.conf
	ln -s `pwd`/tmux/tmux.conf ~/.tmux.conf

xterm:
	rm -rf ~/.Xresources
	rm -rf ~/.Xdefaults
	ln -s `pwd`/xterm/Xresources ~/.Xresources
	ln -s ~/.Xresources ~/.Xdefaults

zsh:
	rm -rf ~/.zshrc
	rm -rf ~/.alias.d
	rm -rf ~/.function.d
	ln -s `pwd`/zsh/zshrc ~/.zshrc
	ln -s `pwd`/zsh/alias.d ~/.alias.d
	ln -s `pwd`/zsh/function.d ~/.function.d
