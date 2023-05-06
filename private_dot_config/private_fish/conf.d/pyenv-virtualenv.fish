if status --is-interactive
  if test -x "$HOMEBREW_PREFIX/bin/pyenv-virtualenv"
    source (pyenv virtualenv-init -|psub)
  end
end
