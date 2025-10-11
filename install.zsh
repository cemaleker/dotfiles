#!/usr/bin/env zsh

set -euo pipefail

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Directories
SCRIPT_DIR="${0:A:h}"
DOTFILES_HOME="${SCRIPT_DIR}/home"
USER_HOME="${HOME}"

# Logging functions
log_info() {
    echo "${GREEN}[INFO]${NC} $1"
}

log_warn() {
    echo "${YELLOW}[WARN]${NC} $1"
}

log_error() {
    echo "${RED}[ERROR]${NC} $1" >&2
}

# Check if dotfiles/home directory exists
if [[ ! -d "${DOTFILES_HOME}" ]]; then
    log_error "Dotfiles home directory not found: ${DOTFILES_HOME}"
    exit 1
fi

# Function to create symlink safely
create_symlink() {
    local source="$1"
    local target="$2"
    local target_name=$(basename "$target")

    # Check if target already exists
    if [[ -L "$target" ]]; then
        local current_link=$(readlink "$target")
        if [[ "$current_link" == "$source" ]]; then
            log_info "Already linked: $target_name"
            return 0
        else
            log_warn "Symlink exists but points to different location: $target_name"
            echo -n "  Current: $current_link\n  New: $source\n  Replace? [y/N] "
            read -r response
            if [[ ! "$response" =~ ^[Yy]$ ]]; then
                log_info "Skipped: $target_name"
                return 0
            fi
            rm "$target"
        fi
    elif [[ -e "$target" ]]; then
        log_warn "File/directory exists: $target_name"
        echo -n "  Backup and replace? [y/N] "
        read -r response
        if [[ ! "$response" =~ ^[Yy]$ ]]; then
            log_info "Skipped: $target_name"
            return 0
        fi
        mv "$target" "${target}.backup.$(date +%Y%m%d_%H%M%S)"
        log_info "Backed up: $target_name"
    fi

    # Create parent directory if needed
    local target_dir=$(dirname "$target")
    if [[ ! -d "$target_dir" ]]; then
        mkdir -p "$target_dir"
        log_info "Created directory: $target_dir"
    fi

    # Create symlink
    ln -s "$source" "$target"
    log_info "Linked: $target_name"
}

# Main installation
log_info "Starting dotfiles installation..."
log_info "Source: ${DOTFILES_HOME}"
log_info "Target: ${USER_HOME}"
echo

# Process all files and directories in dotfiles/home
for item in "${DOTFILES_HOME}"/*(.N) "${DOTFILES_HOME}"/*(D/N); do
    if [[ -e "$item" ]]; then
        item_name=$(basename "$item")
        source_path="$item"
        target_path="${USER_HOME}/.${item_name}"

        create_symlink "$source_path" "$target_path"
    fi
done

echo
log_info "Installation complete!"
