#!/bin/bash

set -e

echo "Cleanup up Cargo symlinks"
rm -f .cargo/bin
if [ -f .cargo/config.original ]; then
    mv .cargo/config.original .cargo/config
fi

echo "Cleaning up git state"
rm -f .git_credentials

export HOME=$PWD
git config --global --unset credential.helper || true
git config --global --unset-all "url.https://github.com/.insteadOf" || true

echo "Done"
exit 0
