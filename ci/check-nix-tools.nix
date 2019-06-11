# This is a a CI check script that runs nix/regenerate.sh in the
# project repository. If anything changes, then it uploads the patch
# to Buildkite and fails the build.
#
# The goal is to ensure that the autogenerated files required by the
# Nix build will always be up to date.

{ stdenv, writeScript, coreutils, nixStable, git }:

with stdenv.lib;

writeScript "check-nix-tools.sh" ''
  #!${stdenv.shell}

  set -euo pipefail

  export PATH="${makeBinPath [ stdenv.shellPackage coreutils nixStable git ]}:$PATH"

  cd $(git rev-parse --show-toplevel)

  fail_nix_tools_check() {
    git diff -w --text > /tmp/nix-tools.patch
    if [ -n "''${BUILDKITE_JOB_ID:-}" ]; then
      buildkite-agent artifact upload /tmp/nix-tools.patch --job "$BUILDKITE_JOB_ID"
    fi
    echo "ERROR: you need to (run ./nix/regenerate.sh or apply the patch in the buildkite artifact) and commit the changes" >&2
    exit 1
  }

  # The regenerate script is here by convention
  ./nix/regenerate.sh

  git diff -w --text --exit-code || fail_nix_tools_check
''
