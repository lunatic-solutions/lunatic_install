# lunatic_install

**One-line commands to install Lunatic on you system.**

## Installation

Lunatic works on macOS, Linux and Windows. Lunatic is a single binary executable.

We provide pre-build binaries for Windows, Linux and macOS. On macOS, both M1 (arm64) and Intel (x64) binaries are provided. On Linux and Windows, only x64 is supported.

## Download and install

[lunatic_install](https://github.com/lunatic-solutions/lunatic_install) provides conveniance scripts to download and install binary.

Using Shell (macOS and Linux):

```
curl -fsSL https://lunatic.solutions/install.sh | sh
```

---

Using PowerShell (Windows):

```
irm https://lunatic.solutions/install.pb1 | iex
```

---

Build and install from source using [Cargo](https://crates.io/crates/lunatic-runtime):

```
cargo install lunatic-runtime
```

Lunatic binaries can also be installed manually, by downloading zip file at https://github.com/lunatic-solutions/lunatic/releases. These packages contain just a single executable file.

## Testing your installation

To test your installation, run `lunatic --version`. If this prints the Lunatic runtime version to the console the installation was successful.

Use `lunatic help` to see help text documenting Lunatic's flags and usage.
