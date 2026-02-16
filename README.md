# kk-pod-cli

Lightweight Kubernetes pod management CLI for local development. Spin up dev environments, map directories, clone pods — all from one command.

Built for **k3s on WSL2** (Windows) but works on native Linux too.

## Install

```bash
curl -sSL https://raw.githubusercontent.com/keiraxlicious/kk-pod-cli/main/install.sh | bash
```

This clones the repo to `~/.kk/kk-pod-cli`, symlinks `kk` and `kk-pod` into `~/.local/bin`, and sets up aliases.

## Quick Start

```bash
# Bootstrap k3s cluster (first time only)
kk pod setup

# Create a blank pod
kk pod create

# List running pods
kk pod ps

# Attach to pod #1
kk pod attach 1

# Map a host directory into a pod
kk pod map /path/to/project 1 /workspace/project

# Clone a pod with all its mounts
kk pod clone 1

# Spin up a Python dev environment
kk pod start-dev python

# Destroy a pod
kk pod kill 1
```

## Pod References

Pods can be referenced three ways:

| Format | Example | Description |
|--------|---------|-------------|
| ID# | `1` | Numeric pod ID |
| Name | `my-env` | Deployment name |
| ID-Tag | `5864d59975-hns6l` | Kubernetes pod hash |

All commands accept any format: `kk pod attach 1`, `kk pod attach my-env`, `kk pod attach 5864d59975-hns6l`

## Commands

### Cluster
| Command | Description |
|---------|-------------|
| `kk pod setup` | Bootstrap k3s in WSL2 |
| `kk pod status` | Cluster overview |
| `kk pod ps` | List running pods |
| `kk pod resources` | Resource usage |
| `kk pod deploy <file>` | Apply a k8s manifest |

### Pods
| Command | Description |
|---------|-------------|
| `kk pod create [name] [--image img]` | Create blank pod |
| `kk pod attach <ref>` | Shell into pod |
| `kk pod run <ref> <cmd...>` | Exec command in pod |
| `kk pod map <host-dir> <ref> <mount>` | Map host dir into pod |
| `kk pod clone <ref> [new-name]` | Clone pod with mounts |
| `kk pod start <ref>` | Scale pod up |
| `kk pod stop <ref>` | Scale pod down |
| `kk pod restart <ref>` | Rolling restart |
| `kk pod kill <ref>` | Destroy pod |
| `kk pod logs <ref> [-f]` | View pod logs |

### Dev Environments
| Command | Description |
|---------|-------------|
| `kk pod start-dev [lang]` | Start env (blank if no lang) |
| `kk pod stop-dev <lang>` | Stop env |
| `kk pod exec <lang> [project]` | Shell into env |

### Game Servers
| Command | Description |
|---------|-------------|
| `kk pod start-game <name>` | Start game server |
| `kk pod stop-game <name>` | Stop game server |

## Dev Environment Templates

44 pre-built templates:

`all` `ansible` `assembly` `bash` `clojure` `cobol` `cpp` `crystal` `d` `dart` `dotnet` `elixir` `erlang` `fortran` `fsharp` `go` `groovy` `haskell` `java` `julia` `kotlin` `lisp` `lua` `mongodb` `nim` `nodejs` `ocaml` `perl` `php` `postgres-dev` `powershell` `prolog` `python` `r` `redis-dev` `ruby` `rust` `scala` `solidity` `swift` `terraform` `v` `wasm` `zig`

## kk CLI

kk-pod-cli includes the **kk** alias manager — a lightweight tool for managing CLI shortcuts:

```bash
# Add a custom alias
kk add claude-d claude --dangerously-skip-permissions

# List aliases
kk list

# Link a project into your workspace
kk link /path/to/project my-project

# Show workspace links
kk links
```

## Requirements

- **WSL2** with Ubuntu (Windows) or native Linux
- **k3s** (installed via `kk pod setup`)
- **git** and **bash**

## Update

```bash
cd ~/.kk/kk-pod-cli && git pull
```

## Uninstall

```bash
rm -rf ~/.kk/kk-pod-cli ~/.local/bin/kk ~/.local/bin/kk-pod ~/.config/kk/aliases/pod ~/.config/kk/aliases/cluster
```

## License

MIT
