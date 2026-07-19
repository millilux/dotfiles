# dotfiles

Cross-platform dotfiles for a **Fedora/Hyprland** primary machine and a **macOS**
work machine. `./setup.sh` provisions either OS; per-app config is deployed with
GNU **stow**.

## Tool responsibilities

The guiding rule is **one owner per role, per platform** — every dependency
belongs to exactly one manager so there's no drift or PATH-shadowing between them.

| Tier | What | Owner (Fedora) | Owner (macOS) |
|------|------|----------------|---------------|
| **1 — System & desktop** | Kernel-adjacent, GUI apps, WM, fonts, drivers (Hyprland, sddm, waybar, mpv, blender…) | `dnf` + copr | Homebrew **casks** |
| **2 — Portable CLI tools** | Editor-agnostic terminal tools (fd, rg, bat, delta, fzf, zoxide, jq, yazi…) | **mise** (aqua/ubi), brew for gaps | **mise**, Homebrew |
| **3 — Runtimes + LSPs** | Language runtimes and all editor tooling (LSPs, formatters, linters) | **mise** | **mise** |

Tier 1 is inherently platform-specific — don't try to unify it. Tiers 2 and 3 are
where **mise** is the single cross-platform source of truth: one `mise.toml`
resolves to the same upstream binaries on both OSes, so nvim / helix / shell / CI
all see identical tools.

### Why mise over brew-on-Linux for Tier 2/3

Homebrew on Linux is a parallel, non-RPM tree in `/home/linuxbrew` that's invisible
to `dnf` and PATH-shadows system packages. mise's `aqua`/`ubi` backends fetch the
same release binaries on both OSes from one declarative file, with no second package
manager to reason about.

## Manifest files

| File | Role |
|------|------|
| `setup.sh` | Orchestrator: installs packages, mise, stows configs, builds the source-only holdouts |
| `mise/.config/mise/config.toml` | **Source of truth** for runtimes + LSPs/formatters/linters (npm:/pipx:/ubi:/aqua: backends) |
| `fedora-packages.txt` | `dnf` packages (Fedora system + desktop) |
| `fedora-copr.txt` | Copr repos enabled *before* `fedora-packages.txt` |
| `Brewfile` | Homebrew formulae (CLI) — macOS and non-`dnf` Linux/WSL; slims as mise absorbs tools |
| `Brewfile.macos` | macOS-only casks + Mac-specific formulae (yabai, skhd, borders…) |
| `requirements.txt` | **Neovim Python-provider libs only** (pynvim, msgpack, ropevim…) — not standalone tools |

## mise: global vs per-project

- **Global** (`mise/.config/mise/config.toml`, this repo): daily-driver runtimes **and
  every LSP** — the editor needs them in every directory.
- **Per-project** (`mise.toml` in a project repo): pins the runtime *version* that
  project needs (`node = "20"`, `python = "3.11"`) and any CI-parity linter pins.
  mise merges the two; project wins.

LSPs are **not** installed per-project — a globally installed server resolves each
project's virtualenv at runtime.

## Special cases (not plain mise backends)

- **pylsp** — the active Python LSP; its plugins must share one venv, which `pipx:`
  can't express. Installed in `setup.sh` via
  `uv tool install python-lsp-server --with <plugin>…`.
- **Neovim Python provider** — `pynvim`/`msgpack`/`ropevim`/`rope`/`debugpy` must live
  in the interpreter nvim calls (`g:python3_host_prog`); kept in `requirements.txt`.
- **Source-build holdouts** (`setup.sh`, no release binaries): `fennel-ls`, `fnlfmt`
  (sourcehut), `ccls`.
- **Toolchain-bound LSPs**: `ocaml-lsp` (via `opam`), `haskell-language-server` (via
  `ghcup`), `fsautocomplete` (via `dotnet`) — the toolchain managers themselves are
  mise-managed.

## Setup

```sh
git clone <this repo> ~/dotfiles && cd ~/dotfiles
./setup.sh
```
