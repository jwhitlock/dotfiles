if test -x /opt/homebrew/Cellar/virtualfish/2.5.5/libexec/bin/vf
    set -g VIRTUALFISH_VERSION 2.5.5
    set -g VIRTUALFISH_PYTHON_EXEC /opt/homebrew/Cellar/virtualfish/2.5.5/libexec/bin/python3.11
    source /opt/homebrew/Cellar/virtualfish/2.5.5/libexec/lib/python3.11/site-packages/virtualfish/virtual.fish
    source /opt/homebrew/Cellar/virtualfish/2.5.5/libexec/lib/python3.11/site-packages/virtualfish/compat_aliases.fish
    source /opt/homebrew/Cellar/virtualfish/2.5.5/libexec/lib/python3.11/site-packages/virtualfish/auto_activation.fish
    source /opt/homebrew/Cellar/virtualfish/2.5.5/libexec/lib/python3.11/site-packages/virtualfish/projects.fish
    emit virtualfish_did_setup_plugins
end
