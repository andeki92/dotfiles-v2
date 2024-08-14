# Dotfiles

## Installation

### Install with stow

> Stow is a symlink farm manager which takes distinct sets of software and/or data located in separate directories on the filesystem, and makes them all appear to be installed in a single directory tree.

Stow is used to symlink everything within the dotfiles repo into the ~/.config directory. On Debian and Ubuntu we can do it like this:

```bash
sudo apt install stow build-essential
```
then we can can symlink everything with the command

```bash
stow --target ~/ --dir config <package>
```

or using the installation script

```bash
./install linux
```
