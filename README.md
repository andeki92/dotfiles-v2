# Dotfiles

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

### Refresh submodules

In some places we use symlinks and git submodules to achieve the effect we want to. That means we occasionally need to update our dependencies/submodules. This can be done with the command:

```bash
git submodule update --init --recursive
```

(we add the init flag here to make sure we initialize any uninitialized submodules)
