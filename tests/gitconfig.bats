# Behavioral tests over chezmoi output, not the dotfiles text.

setup() {
    TESTTEMP="$(mktemp -d)"
    DEST="$TESTTEMP/dest"
    mkdir -p "$DEST"
    # home/ IS the chezmoi source dir (repo-root files are repo docs, not targets)
    printf 'sourceDir = "%s"\n' "$PWD/home" >"$TESTTEMP/omni-config.toml"
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

@test "drop-in lands with editor pin (sourced, not executed — no +x needed)" {
    [ -f "$DEST/.bashrc.d/10-omni.sh" ]
    grep -q 'EDITOR="nvim"' "$DEST/.bashrc.d/10-omni.sh"
}
