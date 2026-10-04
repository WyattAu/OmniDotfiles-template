# bats — behavioral tests over chezmoi output, not the dotfiles text.
setup() {
  TESTTEMP="$(mktemp -d)"
  chezmoi apply --destination "$TESTTEMP" --config-file <(printf 'sourceDir = "%s"\n' "$PWD")
}

teardown() {
  rm -rf "$TESTTEMP"
}

@test "gitconfig renders the user from chezmoidata" {
  grep -q "name = Wyatt Au" "$TESTTEMP/.gitconfig"
  grep -q "defaultBranch = main" "$TESTTEMP/.gitconfig"
}

@test "bashrc sources the drop-in dir" {
  grep -q ".bashrc.d" "$TESTTEMP/.bashrc"
}

@test "drop-in lands with exec bit and editor pin" {
  [ -x "$TESTTEMP/.bashrc.d/10-omni.sh" ]
  grep -q 'EDITOR="nvim"' "$TESTTEMP/.bashrc.d/10-omni.sh"
}
