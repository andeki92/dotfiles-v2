# Dotfiles

## Installation

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

## Scripts

<weight>_<profile>_<host>

## WSL2

### GPG Signing

This is based on the [guide here](https://gist.github.com/matthiasr/473072eeffe449459e3ccd0f5192afc7)

See [this](https://access.redhat.com/solutions/2115511) guide on importing and exporting gpg-keys. This is used along with git-crypt.

## TODOs

Following is a list of stuff I would like to include in the dotfiles repo:

- secure storing of GPG/SSH keys (either with age or git-crypt)
    - it's kinda annoying setting up the GPG-keys each an every time WSL is installed (which should be idempotent)
