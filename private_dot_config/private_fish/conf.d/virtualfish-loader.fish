if set -g VIRTUALFISH_VERSION (/opt/homebrew/bin/brew info --json virtualfish | jq -r ".[0].installed[0].version")
    set -g VIRTUALFISH_PYTHON_EXEC /opt/homebrew/Cellar/virtualfish/{$VIRTUALFISH_VERSION}/libexec/bin/python
    source /opt/homebrew/Cellar/virtualfish/{$VIRTUALFISH_VERSION}/libexec/lib/python3.*/site-packages/virtualfish/virtual.fish
    source /opt/homebrew/Cellar/virtualfish/{$VIRTUALFISH_VERSION}/libexec/lib/python3.*/site-packages/virtualfish/auto_activation.fish
    source /opt/homebrew/Cellar/virtualfish/{$VIRTUALFISH_VERSION}/libexec/lib/python3.*/site-packages/virtualfish/compat_aliases.fish
    emit virtualfish_did_setup_plugins
end
