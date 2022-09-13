
#!/bin/sh
pushd ~/dotfiles
sudo nixos-rebuild switch -I nixos-config=./configuration.nix

# FUTURE ADD FLAKE
# sudo nixos-rebuild switch --flake
popd
