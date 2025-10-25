# Scripts

Custom scripts and utilities for Hyprland and general system use.

## 📁 Structure

```
scripts/
└── .local/
    └── bin/
        └── hypr-screenshot    # Screenshot utility for Hyprland
```

## 🔧 Installation

Use GNU Stow to symlink scripts to your home directory:

```bash
cd ~/dotfiles
stow scripts
```

This will create: `~/.local/bin/hypr-screenshot`

## 📜 Scripts Included

| Script | Description | Dependencies |
|--------|-------------|--------------|
| `hypr-screenshot` | Interactive screenshot tool with multiple capture modes: area selection, window capture, monitor capture, and screenshot editing | `grim`, `slurp`, `wl-clipboard`, `wofi`, `swappy` (optional), `hyprctl` |
