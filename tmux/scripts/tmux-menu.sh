#!/bin/bash

# Exit on any error and treat unset variables as errors
set -euo pipefail

# Check dependencies
for cmd in tmux fzf awk sed xargs; do
    if ! command -v "$cmd" >/dev/null 2>&1; then
        echo "Error: $cmd not found in PATH" >&2
        exit 1
    fi
done

# Check if we're inside tmux
if [ -z "${TMUX:-}" ]; then
    echo "Error: This script should be run from within tmux" >&2
    exit 1
fi

# Check if there are any sessions
if ! tmux list-sessions >/dev/null 2>&1; then
    echo "Error: No tmux sessions found" >&2
    exit 1
fi

# Generate session/window list and handle empty results
session_data=$(
    {
        tmux list-sessions -F '#S' 2>/dev/null | grep -v '^_popup_' | while read -r session; do
            if [ -n "$session" ]; then
                echo "SESSION:$session"
                tmux list-windows -t "$session" -F 'WINDOW:#S:#I #W' 2>/dev/null || true
            fi
        done
    } | sed 's/^SESSION:/▼ /' | sed 's/^WINDOW:/  ⦿ /'
)

# Check if we have any data to display
if [ -z "$session_data" ]; then
    echo "Error: No sessions available (excluding popup sessions)" >&2
    exit 1
fi

# Use fzf with better options and handle user cancellation
target=$(echo "$session_data" | \
    fzf --reverse \
        --height=50% \
        --border \
        --prompt="Select session/window: " \
        --header="▼ Sessions  ⦿ Windows" \
        --no-multi \
        --exit-0 | \
    awk '{
        if ($1 == "▼") {
            print $2
        } else if ($1 == "⦿") {
            print $2
        }
    }'
)

# Handle user cancellation (Esc or Ctrl+C in fzf)
if [ -z "${target:-}" ]; then
    echo "Selection cancelled" >&2
    exit 0
fi

# Switch to target with error handling
if ! tmux switch-client -t "$target" 2>/dev/null; then
    echo "Error: Failed to switch to '$target'" >&2
    exit 1
fi

echo "Switched to: $target"