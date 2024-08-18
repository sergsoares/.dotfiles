# Dotfiles for basic usage

Collection of dotfiles and configuration to be used in several services.

```
git clone https://github.com/sergsoares/.dotfiles
cd .dotfiles
make install
```

To reflect configuration use Stow like in example:

```
stow -S openbox-config/
openbox --restart
stow -S fish-config/
```