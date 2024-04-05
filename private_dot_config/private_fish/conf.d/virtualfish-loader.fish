if test -x /opt/homebrew/Cellar/virtualfish/2.5.7/libexec/bin/vf
  set -g VIRTUALFISH_VERSION 2.5.7
  set -g VIRTUALFISH_PYTHON_EXEC /opt/homebrew/Cellar/virtualfish/2.5.7/libexec/bin/python
  source /opt/homebrew/Cellar/virtualfish/2.5.7/libexec/lib/python3.12/site-packages/virtualfish/virtual.fish
  source /opt/homebrew/Cellar/virtualfish/2.5.7/libexec/lib/python3.12/site-packages/virtualfish/compat_aliases.fish
  source /opt/homebrew/Cellar/virtualfish/2.5.7/libexec/lib/python3.12/site-packages/virtualfish/auto_activation.fish
  source /opt/homebrew/Cellar/virtualfish/2.5.7/libexec/lib/python3.12/site-packages/virtualfish/projects.fish
  emit virtualfish_did_setup_plugins
end
