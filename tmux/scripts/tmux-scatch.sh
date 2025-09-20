#!/bin/bash

# Exit on any error
set -e

# Define session name for scratchpad
session="_popup_scratchpad"

# Check if tmux is available
if ! command -v tmux >/dev/null 2>&1; then
    echo "Error: tmux not found in PATH" >&2
    exit 1
fi

# Check if we're already inside tmux
if [ -z "$TMUX" ]; then
    echo "Error: This script should be run from within tmux" >&2
    exit 1
fi

# Create session if it doesn't exist
if ! tmux has -t "$session" 2>/dev/null; then
    # Create new session with error handling
    if ! session_id="$(tmux new-session -dP -s "$session" -F '#{session_id}' 2>/dev/null)"; then
        echo "Error: Failed to create scratchpad session" >&2
        exit 1
    fi
    
    # Configure session options
    tmux set-option -s -t "$session_id" key-table popup 2>/dev/null || true
    tmux set-option -s -t "$session_id" status off 2>/dev/null || true
    tmux set-option -s -t "$session_id" prefix None 2>/dev/null || true
    session="$session_id"
fi

# Attach to the scratchpad session inside the popup
exec tmux attach -t "$session" 2>/dev/null
