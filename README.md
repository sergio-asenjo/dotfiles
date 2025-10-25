# Dotfiles Bootstrap

Automated setup script for a fresh Arch Linux installation.

## 🚀 Quick Install

**Recommended: Review before running**

```bash
# Download the script
curl -fsSL dotfiles.sergioasenjo.cl/bootstrap.sh -o bootstrap.sh

# Review the script
less bootstrap.sh

# Make it executable
chmod +x bootstrap.sh

# Run the installer
./bootstrap.sh
```

**Alternative: Direct install** (use at your own risk)

```bash
curl -fsSL dotfiles.sergioasenjo.cl/bootstrap.sh | bash
```

## 🔧 After Installation

Once the bootstrap completes, apply your dotfiles with GNU Stow:

```bash
# Clone this repository
git clone https://github.com/sergio-asenjo/dotfiles.git ~/dotfiles
cd ~/dotfiles

# Apply configurations (example)
stow hyprland
stow waybar
stow wezterm
stow wofi

# Or apply all at once
stow */
```

## 📝 Manual Installation

If you prefer to run the script locally:

```bash
git clone https://github.com/sergio-asenjo/dotfiles.git ~/dotfiles
cd ~/dotfiles/bootstrap
./bootstrap.sh
```
