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

58 pre-built templates — spin up any environment with `kk pod start-dev <name>`

### Languages

![Assembly](https://img.shields.io/badge/Assembly-654FF0?style=flat&logo=webassembly&logoColor=white)
![Bash](https://img.shields.io/badge/Bash-4EAA25?style=flat&logo=gnubash&logoColor=white)
![C++](https://img.shields.io/badge/C++-00599C?style=flat&logo=cplusplus&logoColor=white)
![Clojure](https://img.shields.io/badge/Clojure-5881D8?style=flat&logo=clojure&logoColor=white)
![COBOL](https://img.shields.io/badge/COBOL-005CA5?style=flat)
![Crystal](https://img.shields.io/badge/Crystal-000000?style=flat&logo=crystal&logoColor=white)
![D](https://img.shields.io/badge/D-B03931?style=flat&logo=d&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-0175C2?style=flat&logo=dart&logoColor=white)
![Elixir](https://img.shields.io/badge/Elixir-4B275F?style=flat&logo=elixir&logoColor=white)
![Erlang](https://img.shields.io/badge/Erlang-A90533?style=flat&logo=erlang&logoColor=white)
![F#](https://img.shields.io/badge/F%23-378BBA?style=flat&logo=fsharp&logoColor=white)
![Fortran](https://img.shields.io/badge/Fortran-734F96?style=flat&logo=fortran&logoColor=white)
![Go](https://img.shields.io/badge/Go-00ADD8?style=flat&logo=go&logoColor=white)
![Groovy](https://img.shields.io/badge/Groovy-4298B8?style=flat&logo=apachegroovy&logoColor=white)
![Haskell](https://img.shields.io/badge/Haskell-5D4F85?style=flat&logo=haskell&logoColor=white)
![Java](https://img.shields.io/badge/Java-ED8B00?style=flat&logo=openjdk&logoColor=white)
![JavaScript](https://img.shields.io/badge/JavaScript-F7DF1E?style=flat&logo=javascript&logoColor=black)
![Julia](https://img.shields.io/badge/Julia-9558B2?style=flat&logo=julia&logoColor=white)
![Kotlin](https://img.shields.io/badge/Kotlin-7F52FF?style=flat&logo=kotlin&logoColor=white)
![Lisp](https://img.shields.io/badge/Lisp-3F5E8A?style=flat)
![Lua](https://img.shields.io/badge/Lua-2C2D72?style=flat&logo=lua&logoColor=white)
![Nim](https://img.shields.io/badge/Nim-FFE953?style=flat&logo=nim&logoColor=black)
![OCaml](https://img.shields.io/badge/OCaml-EC6813?style=flat&logo=ocaml&logoColor=white)
![Perl](https://img.shields.io/badge/Perl-39457E?style=flat&logo=perl&logoColor=white)
![PHP](https://img.shields.io/badge/PHP-777BB4?style=flat&logo=php&logoColor=white)
![Prolog](https://img.shields.io/badge/Prolog-E61B23?style=flat)
![Python](https://img.shields.io/badge/Python-3776AB?style=flat&logo=python&logoColor=white)
![R](https://img.shields.io/badge/R-276DC3?style=flat&logo=r&logoColor=white)
![Ruby](https://img.shields.io/badge/Ruby-CC342D?style=flat&logo=ruby&logoColor=white)
![Rust](https://img.shields.io/badge/Rust-000000?style=flat&logo=rust&logoColor=white)
![Scala](https://img.shields.io/badge/Scala-DC322F?style=flat&logo=scala&logoColor=white)
![Solidity](https://img.shields.io/badge/Solidity-363636?style=flat&logo=solidity&logoColor=white)
![Swift](https://img.shields.io/badge/Swift-F05138?style=flat&logo=swift&logoColor=white)
![TypeScript](https://img.shields.io/badge/TypeScript-3178C6?style=flat&logo=typescript&logoColor=white)
![V](https://img.shields.io/badge/V-5D87BF?style=flat)
![WASM](https://img.shields.io/badge/WebAssembly-654FF0?style=flat&logo=webassembly&logoColor=white)
![Zig](https://img.shields.io/badge/Zig-F7A41D?style=flat&logo=zig&logoColor=black)

### Web Frameworks

![React](https://img.shields.io/badge/React-61DAFB?style=flat&logo=react&logoColor=black)
![Vue](https://img.shields.io/badge/Vue.js-4FC08D?style=flat&logo=vuedotjs&logoColor=white)
![Angular](https://img.shields.io/badge/Angular-DD0031?style=flat&logo=angular&logoColor=white)
![Svelte](https://img.shields.io/badge/Svelte-FF3E00?style=flat&logo=svelte&logoColor=white)
![Next.js](https://img.shields.io/badge/Next.js-000000?style=flat&logo=nextdotjs&logoColor=white)
![Astro](https://img.shields.io/badge/Astro-BC52EE?style=flat&logo=astro&logoColor=white)
![Django](https://img.shields.io/badge/Django-092E20?style=flat&logo=django&logoColor=white)
![Flask](https://img.shields.io/badge/Flask-000000?style=flat&logo=flask&logoColor=white)
![FastAPI](https://img.shields.io/badge/FastAPI-009688?style=flat&logo=fastapi&logoColor=white)
![HTML](https://img.shields.io/badge/HTML-E34F26?style=flat&logo=html5&logoColor=white)

### Servers & Infrastructure

![Nginx](https://img.shields.io/badge/Nginx-009639?style=flat&logo=nginx&logoColor=white)
![Caddy](https://img.shields.io/badge/Caddy-1F88C0?style=flat)
![Node.js](https://img.shields.io/badge/Node.js-5FA04E?style=flat&logo=nodedotjs&logoColor=white)
![.NET](https://img.shields.io/badge/.NET-512BD4?style=flat&logo=dotnet&logoColor=white)
![MongoDB](https://img.shields.io/badge/MongoDB-47A248?style=flat&logo=mongodb&logoColor=white)
![PostgreSQL](https://img.shields.io/badge/PostgreSQL-4169E1?style=flat&logo=postgresql&logoColor=white)
![Redis](https://img.shields.io/badge/Redis-FF4438?style=flat&logo=redis&logoColor=white)
![Ansible](https://img.shields.io/badge/Ansible-EE0000?style=flat&logo=ansible&logoColor=white)
![Terraform](https://img.shields.io/badge/Terraform-844FBA?style=flat&logo=terraform&logoColor=white)
![PowerShell](https://img.shields.io/badge/PowerShell-5391FE?style=flat&logo=powershell&logoColor=white)

### Web Ports (NodePort access from host)

| Template | Ports | Host Access |
|----------|-------|-------------|
| `html` | 80 | `localhost:30080` |
| `react` | 3000, 5173 | `localhost:30300`, `localhost:30517` |
| `vue` | 3000, 5173 | `localhost:30303`, `localhost:30518` |
| `angular` | 4200 | `localhost:30420` |
| `svelte` | 5173, 3000 | `localhost:30519`, `localhost:30304` |
| `nextjs` | 3000 | `localhost:30305` |
| `astro` | 4321 | `localhost:30432` |
| `django` | 8000 | `localhost:30800` |
| `flask` | 5000 | `localhost:30500` |
| `fastapi` | 8000 | `localhost:30801` |
| `nginx` | 80, 443 | `localhost:30081`, `localhost:30443` |
| `caddy` | 80, 443 | `localhost:30082`, `localhost:30444` |

> Use `all` for a complete environment with every language and tool installed.

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
