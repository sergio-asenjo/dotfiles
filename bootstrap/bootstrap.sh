#!/bin/bash

# Dotfiles Bootstrap Script
# This script sets up a fresh Arch Linux installation with all necessary packages

set -e  # Exit on error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Helper functions
print_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if running on Arch Linux
check_arch_linux() {
    print_info "Checking if running on Arch Linux..."
    if [ ! -f /etc/arch-release ]; then
        print_error "This script is designed for Arch Linux only!"
        exit 1
    fi
    print_success "Arch Linux detected"
}

# Check if git is installed
check_git() {
    print_info "Checking for git installation..."
    if ! command -v git &> /dev/null; then
        print_warning "Git is not installed. Installing git..."
        sudo pacman -S --needed --noconfirm git
        print_success "Git installed successfully"
    else
        print_success "Git is already installed ($(git --version))"
    fi
}

# Update system
update_system() {
    print_info "Updating system packages..."
    sudo pacman -Syu --noconfirm
    print_success "System updated"
}

# Install pacman packages
install_pacman_packages() {
    local pkglist="$1"
    
    if [ ! -f "$pkglist" ]; then
        print_error "Package list not found: $pkglist"
        exit 1
    fi
    
    print_info "Installing official repository packages..."
    
    # Read packages and filter out empty lines
    local packages=$(grep -v '^#' "$pkglist" | grep -v '^$' | tr '\n' ' ')
    
    if [ -z "$packages" ]; then
        print_warning "No packages to install from $pkglist"
        return
    fi
    
    print_info "Packages to install: $packages"
    sudo pacman -S --needed --noconfirm $packages
    print_success "Official packages installed successfully"
}

# Check if paru is installed, if not install it
check_install_paru() {
    print_info "Checking for paru (AUR helper)..."
    
    if command -v paru &> /dev/null; then
        print_success "Paru is already installed"
        return
    fi
    
    print_warning "Paru not found. Installing paru..."
    
    # Install dependencies for building paru
    sudo pacman -S --needed --noconfirm base-devel rust
    
    # Clone and build paru
    local temp_dir=$(mktemp -d)
    cd "$temp_dir"
    
    print_info "Cloning paru from AUR..."
    git clone https://aur.archlinux.org/paru.git
    cd paru
    
    print_info "Building and installing paru..."
    makepkg -si --noconfirm
    
    cd -
    rm -rf "$temp_dir"
    
    print_success "Paru installed successfully"
}

# Install AUR packages
install_aur_packages() {
    local pkglist="$1"
    
    if [ ! -f "$pkglist" ]; then
        print_error "AUR package list not found: $pkglist"
        exit 1
    fi
    
    print_info "Installing AUR packages..."
    
    # Read packages and filter out empty lines
    local packages=$(grep -v '^#' "$pkglist" | grep -v '^$' | tr '\n' ' ')
    
    if [ -z "$packages" ]; then
        print_warning "No AUR packages to install from $pkglist"
        return
    fi
    
    print_info "AUR packages to install: $packages"
    paru -S --needed --noconfirm $packages
    print_success "AUR packages installed successfully"
}

# Ensure stow is installed and ready
check_stow() {
    print_info "Checking for GNU Stow..."
    
    if ! command -v stow &> /dev/null; then
        print_warning "Stow not found. Installing stow..."
        sudo pacman -S --needed --noconfirm stow
    fi
    
    print_success "GNU Stow is installed and ready ($(stow --version | head -n1))"
}

# Main execution
main() {
    print_info "Starting dotfiles bootstrap process..."
    echo ""
    
    # Get the directory where the script is located
    SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
    PACMAN_PKGLIST="$SCRIPT_DIR/pacman-pkglist.txt"
    AUR_PKGLIST="$SCRIPT_DIR/aur-pkglist.txt"
    
    # Run checks and installations
    check_arch_linux
    check_git
    
    # Ask for confirmation before proceeding
    echo ""
    print_warning "This script will:"
    echo "  1. Update your system"
    echo "  2. Install $(wc -l < "$PACMAN_PKGLIST" 2>/dev/null || echo "?") official packages"
    echo "  3. Install paru (if not already installed)"
    echo "  4. Install $(wc -l < "$AUR_PKGLIST" 2>/dev/null || echo "?") AUR packages"
    echo "  5. Ensure stow is ready for use"
    echo ""
    
    read -p "Do you want to continue? (y/N) " -n 1 -r
    echo ""
    
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        print_info "Bootstrap cancelled by user"
        exit 0
    fi
    
    echo ""
    update_system
    echo ""
    
    install_pacman_packages "$PACMAN_PKGLIST"
    echo ""
    
    check_install_paru
    echo ""
    
    install_aur_packages "$AUR_PKGLIST"
    echo ""
    
    check_stow
    echo ""
    
    print_success "Bootstrap completed successfully!"
    echo ""
    print_info "Next steps:"
    echo "  1. Navigate to your dotfiles directory"
    echo "  2. Use 'stow <package>' to symlink configurations (e.g., 'stow hyprland')"
    echo "  3. Reboot or restart your session if needed"
    echo ""
}

# Run main function
main "$@"
