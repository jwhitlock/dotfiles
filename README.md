# chezmoi dotfiles

These configuration files are managed by [chezmoi](https://www.chezmoi.io).

Thanks to [jsatt](https://github.com/jsatt/dotfiles) for suggesting `chezmoi`.

This only works on macOS, developed with Ventura. It assumes
[Homebrew](https://brew.sh) is installed.

```
brew doctor  # Get homebrew happy
brew install chezmoi
chezmoi init --ssh --apply jwhitlock
```
