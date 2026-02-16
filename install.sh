#!/usr/bin/env bash
# KiraKota Pod CLI - 1-line installer
# curl -sSL https://raw.githubusercontent.com/keiraxlicious/kk-pod-cli/main/install.sh | bash
set -euo pipefail

GREEN='\033[0;32m'; CYAN='\033[0;36m'; BOLD='\033[1m'; DIM='\033[2m'; NC='\033[0m'
info() { echo -e "${GREEN}[kk]${NC} $*"; }

KK_REPO="https://github.com/keiraxlicious/kk-pod-cli.git"
INSTALL_DIR="${HOME}/.kk/kk-pod-cli"
BIN_DIR="${HOME}/.local/bin"
CONFIG_DIR="${HOME}/.config/kk/aliases"

info "Installing kk-pod-cli..."

# --- Clone or update repo ---
mkdir -p "$(dirname "$INSTALL_DIR")"
if [[ -d "${INSTALL_DIR}/.git" ]]; then
    info "Updating existing installation..."
    git -C "$INSTALL_DIR" pull --ff-only 2>/dev/null || {
        info "Pull failed, re-cloning..."
        rm -rf "$INSTALL_DIR"
        git clone --depth 1 "$KK_REPO" "$INSTALL_DIR"
    }
else
    [[ -d "$INSTALL_DIR" ]] && rm -rf "$INSTALL_DIR"
    git clone --depth 1 "$KK_REPO" "$INSTALL_DIR"
fi

# --- Symlink binaries ---
mkdir -p "$BIN_DIR" "$CONFIG_DIR"

ln -sf "${INSTALL_DIR}/bin/kk" "${BIN_DIR}/kk"
ln -sf "${INSTALL_DIR}/bin/kk-pod" "${BIN_DIR}/kk-pod"
chmod +x "${INSTALL_DIR}/bin/kk" "${INSTALL_DIR}/bin/kk-pod"

# --- Set up aliases ---
printf 'CMD=%s\nDESC=%s\n' "${BIN_DIR}/kk-pod" "KiraKota Pod Management" > "${CONFIG_DIR}/pod"
printf 'CMD=%s\nDESC=%s\n' "${BIN_DIR}/kk-pod" "KiraKota Cluster Management" > "${CONFIG_DIR}/cluster"

# --- Ensure PATH ---
if ! echo "$PATH" | tr ':' '\n' | grep -qx "$BIN_DIR"; then
    for rc in ~/.bashrc ~/.zshrc; do
        if [[ -f "$rc" ]] && ! grep -q '\.local/bin' "$rc" 2>/dev/null; then
            echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$rc"
        fi
    done
    export PATH="${BIN_DIR}:${PATH}"
fi

echo ""
info "kk-pod-cli installed!"
echo ""
echo -e "  ${CYAN}kk pod help${NC}     Show all commands"
echo -e "  ${CYAN}kk pod setup${NC}    Bootstrap k3s cluster"
echo -e "  ${CYAN}kk pod create${NC}   Create a blank pod"
echo -e "  ${CYAN}kk pod ps${NC}       List running pods"
echo ""
echo -e "  ${DIM}Update:  cd ~/.kk/kk-pod-cli && git pull${NC}"
echo -e "  ${DIM}Remove:  rm -rf ~/.kk/kk-pod-cli ~/.local/bin/kk ~/.local/bin/kk-pod${NC}"
