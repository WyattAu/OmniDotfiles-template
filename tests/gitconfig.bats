# Behavioral tests over chezmoi output, not the dotfiles text.

setup() {
    TESTTEMP="$(mktemp -d)"
    DEST="$TESTTEMP/dest"
    printf 'sourceDir = "%s"\n' "$PWD" >"$TESTTEMP/omni-config.toml"
    chezmoi apply --destination "$DEST" --config "$TESTTEMP/omni-config.toml"
}

teardown() {
    rm -rf "$TESTTEMP"
}

@test "gitconfig renders the user from chezmoidata" {
    grep -q "name = Wyatt Au" "$DEST/.gitconfig"
    grep -q "defaultBranch = main" "$DEST/.gitconfig"
}

@test "bashrc sources the drop-in dir" {
    grep -q ".bashrc.d" "$DEST/.bashrc"
}

@test "drop-in lands with exec bit and editor pin" {
    [ -x "$DEST/.bashrc.d/10-omni.sh" ]
    grep -q 'EDITOR="nvim"' "$DEST/.bashrc.d/10-omni.sh"
}
