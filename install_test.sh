#!/bin/sh

set -e

# Test that we can install the latest version at default location.
rm -f ~/.lunatic/bin/lunatic
unset LUNATIC_INSTALL
sh ./install.sh
~/.lunatic/bin/lunatic --version

# Test that we can install specific version at custom location.
rm -rf ~/lunatic-0.12.0
export LUNATIC_INSTALL="$HOME/lunatic-0.12.0"
./install.sh v0.12.0
~/lunatic-0.12.0/bin/lunatic --version | grep 0.12.0
rm -rf ~/lunatic-0.12.0