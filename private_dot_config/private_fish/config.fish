if status is-interactive
  # Commands to run in interactive sessions can go here

  if test -d /opt/homebrew/bin
    fish_add_path /opt/homebrew/bin

    if test -x /opt/homebrew/bin/pyenv
      pyenv init --path | source
      pyenv init - | source
    end
  end

  if test -d /opt/homebrew/sbin
    fish_add_path /opt/homebrew/sbin
  end
end

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/john/google-cloud-sdk/path.fish.inc' ]; . '/Users/john/google-cloud-sdk/path.fish.inc'; end

fish_add_path --append "$HOME/.local/bin"

set -gx VOLTA_HOME "$HOME/.volta"
fish_add_path "$VOLTA_HOME/bin"
