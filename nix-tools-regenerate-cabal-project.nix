# A script for generating the nix haskell package set based on stackage,
# using the common convention for repo layout.

# Takes a parameter list of all the packages (as strings) that it
# should regenerate.

{ lib, stdenv, path, writeScript, nix-tools, coreutils, nix, nix-prefetch-git, packages }:

let
  deps = [ nix-tools coreutils nix nix-prefetch-git ];
in
  writeScript "nix-tools-regenerate-cabal-project" ''
    #!${stdenv.shell}
    #
    # Haskell package set regeneration script.
    #
    # cabal-to-nix will transform the cabal.project file into something
    # nix can understand.
    #

    set -euo pipefail
    export PATH=${lib.makeBinPath deps}
    export NIX_PATH=nixpkgs=${path}
    export packages="${builtins.concatStringsSep " " packages}"


    dest=nix/.cabal-project-overlay

    mkdir -p $dest

    function cleanup {
      rm -f "$dest/*.new"
    }
    trap cleanup EXIT

    for pkg in $packages
    do
      cabal-to-nix $pkg > "$dest/$pkg.nix.new"
      mv "$dest/$pkg.nix.new" "$dest/$pkg.nix"
      echo "Wrote $dest/$pkg.nix"
    done
    echo "{" > $dest/overlay.nix
    for pkg in $packages
    do
      echo "$pkg = ./$dest/$pkg.nix;" >> $dest/overlay.nix
    done
    echo "}" >> $dest/overlay.nix
    echo "Generated $dest/overlay.nix"
  ''
