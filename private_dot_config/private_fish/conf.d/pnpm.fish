if test -x "$HOME/Library/pnpm"
  set -gx PNPM_HOME "$HOME/Library/pnpm"
  fish_add_path "$PNPM_HOME"
end
