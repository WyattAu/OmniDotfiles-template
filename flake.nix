{
  # OmniDotfiles dev environment — nix owns the dotfiles gate toolchain.
  description = "OmniDotfiles-template development environment";

  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }:
    let
      systems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
      forAllSystems = f: nixpkgs.lib.genAttrs systems (s: f nixpkgs.legacyPackages.${s});
    in
    {
      devShells = forAllSystems (pkgs: {
        default = pkgs.mkShell {
          packages = with pkgs; [
            chezmoi
            shellcheck
            shfmt
            bats
            git
            # optional heavy role scaffold (dotfiles parity with the estate):
            # ansible
          ];
        };
      });
    };
}
