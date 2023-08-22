#!/bin/sh

set -e

if ! command -v tar >/dev/null; then
	echo "Error: tar is required to install Lunatic Runtime." 1>&2
	exit 1
fi

if [ "$OS" = "Windows_NT" ]; then
	target="windows-amd64"
else
	case $(uname -sm) in
	"Darwin") target="macos-universal" ;;
	"Linux aarch64")
		echo "Error: Official Lunatic Runtime builds for Linux aarch64 are not available."
		exit 1
		;;
	*) target="linux-amd64" ;;
	esac
fi

if [ $# -eq 0 ]; then
	lunatic_uri="https://github.com/lunatic-solutions/lunatic/releases/latest/download/lunatic-${target}.tar.gz"
else
	lunatic_uri="https://github.com/lunatic-solutions/lunatic/releases/download/${1}/lunatic-${target}.tar.gz"
fi

lunatic_install="${LUNATIC_INSTALL:-$HOME/.lunatic}"
bin_dir="$lunatic_install/bin"
exe="$bin_dir/lunatic"

if [ ! -d "$bin_dir" ]; then
	mkdir -p "$bin_dir"
fi

curl --fail --location --progress-bar --output "$exe.tar.gz" "$lunatic_uri"
tar -xf "$exe.tar.gz" -C "$bin_dir"
chmod +x "$exe"
rm "$exe.tar.gz"

echo "Lunatic was installed successfully to $exe"

if command -v lunatic >/dev/null; then
	echo "Run 'lunatic --help' to get started"
else
	case $SHELL in
	/bin/zsh) shell_profile=".zshrc" ;;
	*) shell_profile=".bashrc" ;;
	esac
	echo "Manually add the directory to your \$HOME/$shell_profile (or similar)"
	echo "  export LUNATIC_INSTALL=\"$lunatic_install\""
	echo "  export PATH=\"\$LUNATIC_INSTALL/bin:\$PATH\""
	echo "Run '$exe --help' to get started"
fi
echo
echo "Stuck? Join our Discord https://discord.gg/fZR5wxNp"
