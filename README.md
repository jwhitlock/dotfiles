# chezmoi dotfiles

These configuration files are managed by [chezmoi](https://www.chezmoi.io).

Thanks to [jsatt](https://github.com/jsatt/dotfiles) for suggesting `chezmoi`.

This only works on macOS, developed with Ventura, tested up to Tahoe. It assumes
[Homebrew](https://brew.sh) is installed.

```
brew doctor  # Get homebrew happy
brew install chezmoi
chezmoi init --ssh --apply jwhitlock
```

## Pre-install
In February 2026 I got the chance to get this setup a laptop from scratch again. But I didn't take great notes.

Before you can run this:

* Install MacOS, get Apple ID setup
* Set computer name, and hostname in sharing. I like a human-focused machine name, and `jwhitlock-mb-m2` for hostname
* Install 1Password, setup
* Install Homebrew, which also brings in XCode command line tools
* Create a new SSH key, add to GitHub

Manual stuff after running:
* Add sections for new `machineName`, mostly to the fish paths
* `sudo vi /etc/shells`, add fish `/opt/homebrew/bin/fish`
* `chsh -s /opt/homebrew/bin/fish`
* Safari: Add extensions for 1Password, OmSave
* Safari: Preferences Advanced, Show Features for Web Developers
* Ollama - `brew services start ollama`, then `ask_deepseek` to start downloading the model
* Docker Desktop - Run, skip email. Under Settings /General, install the fish completions
* In App Store, install XCode
* System Preferences, Customize Modifier Keys: Change Caps Lock to ^ Control (for each keyboard)
