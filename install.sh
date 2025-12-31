#!/bin/sh

INSTALL_DIR="/usr/local/bin"
TARGET="${INSTALL_DIR}/no"

# Must run as root
if [ "$(id -u)" -ne 0 ]; then
    echo "Error: this script must be run as root (use su or doas)"
    exit 1
fi

# Determine action: install (default) or remove
ACTION="$1"

if [ "$ACTION" = "remove" ]; then
    if [ -f "$TARGET" ]; then
        rm -f "$TARGET"
        echo "'no' removed from $TARGET"
    else
        echo "'no' is not installed"
    fi
    exit 0
fi

# Install 'no'
echo "Installing 'no' to $TARGET..."
mkdir -p "$INSTALL_DIR"

cat > "$TARGET" << 'EOF'
#!/bin/sh
if [ "$#" -eq 0 ]; then
    exec yes n
else
    exec yes "$*"
fi
EOF

chmod 0755 "$TARGET"
echo "Installed successfully! Test with: no | head"
