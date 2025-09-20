# Tmux Configuration

A comprehensive tmux configuration with custom keybindings, popup windows, and enhanced functionality for improved terminal multiplexing experience.

## 📁 Project Structure

```
tmux/
├── tmux.conf           # Main tmux configuration file
└── scripts/
    ├── tmux-menu.sh    # Interactive session/window selector
    └── tmux-scratch.sh # Scratchpad popup session manager
```

## 🚀 Features

### Core Configuration

- **Custom Prefix**: Changed from `Ctrl-b` to `Ctrl-a` for easier access
- **256 Color Support**: Full color terminal support
- **Mouse Support**: Click to select panes and resize
- **Vim-style Navigation**: Vi keybindings for copy mode
- **Enhanced History**: 50,000 lines of scrollback buffer

### Key Bindings

#### Window & Pane Management

| Key Binding  | Action                                 |
| ------------ | -------------------------------------- |
| `Prefix + c` | Create new window in current directory |
| `Prefix + +` | Split window horizontally              |
| `Prefix + -` | Split window vertically                |
| `Prefix + r` | Reload tmux configuration              |

#### Pane Navigation & Resizing

| Key Binding        | Action                         |
| ------------------ | ------------------------------ |
| `Prefix + h/j/k/l` | Resize pane left/down/up/right |
| `Prefix + m`       | Maximize/restore pane          |

#### Copy Mode (Vim-style)

| Key Binding | Action          |
| ----------- | --------------- |
| `v`         | Begin selection |
| `y`         | Copy selection  |

#### Popup Windows

| Key Binding  | Action                       |
| ------------ | ---------------------------- |
| `Prefix + w` | Open session/window selector |
| `Ctrl + t`   | Toggle scratchpad popup      |
| `Prefix + g` | Open LazyGit in popup        |

### Custom Scripts

#### Session Menu (`tmux-menu.sh`)

- Interactive session and window browser using `fzf`
- Quick switching between sessions and windows
- Filters out popup sessions for cleaner interface

#### Scratchpad (`tmux-scratch.sh`)

- Persistent scratchpad session in popup window
- Ideal for quick notes, calculations, or temporary work
- Automatically creates session if it doesn't exist

### Plugins

The configuration uses [TPM (Tmux Plugin Manager)](https://github.com/tmux-plugins/tpm) with the following plugins:

- **vim-tmux-navigator**: Seamless navigation between vim and tmux panes
- **tmux-resurrect**: Save and restore tmux sessions
- **tmux-continuum**: Automatic session saving every minute
- **tmux-yank**: Enhanced copy functionality
- **tmux-sensible**: Sensible default settings
- **tmux-themepack**: Beautiful themes (using powerline/cyan theme)

### Status Bar

Custom status bar configuration with:

- **Left**: Session name with tmux icon and visual separators
- **Right**: Time, date, and user@hostname information
- **Window indicators**: Custom formatting with icons

## 🔧 Installation

### Prerequisites

Ensure you have the following dependencies installed:

- `tmux`
- `fzf` (for interactive menus)
- `lazygit` (optional, for git popup)

### Setup Steps

1. **Clone or copy the configuration**:

   ```bash
   # Create tmux config directory
   mkdir -p ~/.config/tmux/scripts

   # Copy configuration files
   cp tmux/tmux.conf ~/.config/tmux/
   cp tmux/scripts/* ~/.config/tmux/scripts/
   ```

2. **Make scripts executable**:

   ```bash
   chmod +x ~/.config/tmux/scripts/*.sh
   ```

3. **Install TPM (if not already installed)**:

   ```bash
   git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
   ```

4. **Start tmux and install plugins**:

   ```bash
   tmux
   # Inside tmux, press: Prefix + I (capital i) to install plugins
   ```

5. **Reload configuration**:
   ```bash
   # Inside tmux, press: Prefix + r
   ```

## 🎯 Usage

### Basic Workflow

1. Start tmux: `tmux`
2. Create new windows: `Prefix + c`
3. Split panes: `Prefix + +` (horizontal) or `Prefix + -` (vertical)
4. Navigate between sessions: `Prefix + w`
5. Quick scratchpad: `Ctrl + t`

### Session Management

- Use `Prefix + w` to open the interactive session/window selector
- Sessions and windows are displayed in a tree-like structure
- Use arrow keys or vim navigation to select and press Enter

### Scratchpad Usage

- Press `Ctrl + t` to toggle the scratchpad popup
- The scratchpad persists across tmux sessions
- Perfect for temporary notes, calculations, or quick commands

## 🎨 Customization

### Modifying Key Bindings

Edit `tmux.conf` and change bindings as needed. Common modifications:

```bash
# Change prefix key
set -g prefix C-a

# Add custom binding
bind-key x kill-pane
```

### Theme Customization

The configuration uses the powerline cyan theme. To change:

```bash
set -g @themepack 'powerline/default/blue'  # or other available themes
```

### Script Customization

Both scripts accept environment variables and can be modified:

- `tmux-menu.sh`: Customize fzf options or session filtering
- `tmux-scratch.sh`: Change session name or default settings

## 🐛 Troubleshooting

### Common Issues

**Scripts not working**: Ensure scripts are executable and in the correct path

```bash
ls -la ~/.config/tmux/scripts/
chmod +x ~/.config/tmux/scripts/*.sh
```

**Plugins not loading**: Make sure TPM is installed and plugins are installed

```bash
# Install TPM
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
# In tmux: Prefix + I
```

**fzf not found**: Install fzf for menu functionality

```bash
# macOS
brew install fzf

# Ubuntu/Debian
sudo apt install fzf
```

## 📝 License

This configuration is provided as-is for personal use. Feel free to modify and distribute.

## 🤝 Contributing

Feel free to submit issues or pull requests for improvements to this tmux configuration.
