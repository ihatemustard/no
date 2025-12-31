#!/bin/sh

INSTALL_DIR="/usr/local/bin"
TARGET="${INSTALL_DIR}/no"

clear
echo "=== no manager ==="
echo
echo "1) Install no"
echo "2) Remove no"
echo "3) Cancel"
echo
printf "Select an option [1-3]: "
read choice

# Require root for install/remove
need_root() {
    if [ "$(id -u)" -ne 0 ]; then
        echo "Error: must be run as root (use su or doas)"
        exit 1
    fi
}

case "$choice" in
    1)
        need_root
        echo "Installing 'no'..."

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

        echo "Installed: $TARGET"
        echo "Test with: no | head"
        ;;
    2)
        need_root
        if [ -f "$TARGET" ]; then
            rm "$TARGET"
            echo "Removed: $TARGET"
        else
            echo "'no' is not installed."
        fi
        ;;
    3)
        echo "Cancelled."
        exit 0
        ;;
    *)
        echo "Invalid option."
        exit 1
        ;;
esac
