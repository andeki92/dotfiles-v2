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

## Storing secrets in Git

To store secrets (obviously encrypted) in git we use [git-crypt](https://github.com/AGWA/git-crypt). Using a .gitattributes filter we can ensure everything is encrypted before being pushed to git and locally decrypted. Files stored in ./secrets will be encrypted and decrypted like this and will require `git-crypt unlock` to unlock.

### Exporting GPG-keys

The following commands are used to export GPG-keys:


```
gpg -a --export >~/.dotfiles/secrets/gpg/public_keys.asc
gpg -a --export-secret-keys >~/.dotfiles/secrets/gpg/private_keys.asc
gpg --export-ownertrust >~/.dotfiles/secrets/gpgotrust.txt
```

## TODOs

Following is a list of stuff I would like to include in the dotfiles repo:

- secure storing of GPG/SSH keys (either with age or git-crypt)
    - it's kinda annoying setting up the GPG-keys each an every time WSL is installed (which should be idempotent)
