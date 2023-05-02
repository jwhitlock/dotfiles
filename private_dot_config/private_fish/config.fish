if status is-interactive
  # Commands to run in interactive sessions can go here
  if test -x /opt/homebrew/bin/brew
    # MacOS, ARM
    set -gx HOMEBREW_PREFIX "/opt/homebrew"
  else if test -x /usr/local/bin/brew
    # MacOS, Intel
    set -gx HOMEBREW_PREFIX "/usr/local"
  else
    set -g --erase HOMEBREW_PREFIX
  end

  if test "$HOMEBREW_PREFIX" != ""
    # Set just HOMEBREW_PREFIX, _CELLAR, etc.
    eval ($HOMEBREW_PREFIX/bin/brew shellenv | grep -v PATH)

    fish_add_path "$HOMEBREW_PREFIX/sbin"
    fish_add_path "$HOMEBREW_PREFIX/bin"

    set -q MANPATH; or set MANPATH ''
    set BREW_MANPATH "$HOMEBREW_PREFIX/share/man"
    if not contains $BREW_MANPATH $MANPATH
      set -gx MANPATH $BREW_MANPATH $MANPATH;
    end

    set -q INFOPATH; or set INFOPATH ''
    set BREW_INFOPATH "$HOMEBREW_PREFIX/share/info"
    if not contains $BREW_INFOPATH $INFOPATH
      set -gx INFOPATH $BREW_INFOPATH $INFOPATH;
    end

    if test -x "$HOMEBREW_PREFIX/bin/pyenv"
      "$HOMEBREW_PREFIX/bin/pyenv" init - | source
    end

    set -gx VISUAL "$HOMEBREW_PREFIX/bin/mvim --nofork"
    set -gx EDITOR "$HOMEBREW_PREFIX/bin/mvim -v --nofork"

  end

  if test -x "$HOMEBREW_PREFIX/bin/volta"
    set -gx VOLTA_HOME "$HOME/.volta"
    fish_add_path "$VOLTA_HOME/bin"
  end

  # Google Cloud SDK
  if test -f "$HOME/google-cloud-sdk/path.fish.inc"
    . "$HOME/google-cloud-sdk/path.fish.inc"
  end
end

fish_add_path --append "$HOME/.local/bin"
