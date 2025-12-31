#!/bin/sh

INSTALL_DIR="/usr/local/bin"
TARGET="${INSTALL_DIR}/no"

clear
echo "=== no v1.1 installer ==="
echo
echo "1) Install no"
echo "2) Remove no"
echo "3) Cancel"
echo
printf "Select an option [1-3]: "
read choice

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

VERSION="1.1"

TEXT="n"
INTERVAL=0
TIMES=0
USE_RANDOM=0
RANDOM_ITEMS=""
USE_COUNT=0
OUTPUT=""
COMMAND=""

usage() {
    echo "Usage: no [text] [options]"
    echo
    echo "Options:"
    echo "  -i, --interval <seconds>   Add a delay between outputs"
    echo "  -v, --version              Show version info"
    echo "  -h, --help                 Show this help"
    echo "  -r, --random <list>        Repeat random strings from comma-separated list"
    echo "  -c, --count                Prepend counter to each output"
    echo "  -o, --output <file>        Write output to a file instead of stdout"
    echo "  -t, --times <n>            Number of times to repeat (0 = infinite)"
    echo "  -cmd, --command <cmd>      Execute a shell command repeatedly and print its output"
    echo
    echo "Examples:"
    echo "  no"
    echo "  no example -o file.txt"
    echo "  no --interval 0.5 --times 5"
    echo "  no --random \"no,nah,nop\" --times 4"
    echo "  no --count --times 3"
    echo "  no --command \"date\" --times 3 --interval 1"
    exit 0
}

pick_random() {
    LIST="$1"
    COUNT=$(echo "$LIST" | awk -F',' '{print NF}')
    RAND_BYTE=$(od -An -N2 -tu2 /dev/urandom | tr -d ' ')
    INDEX=$(( (RAND_BYTE % COUNT) + 1 ))
    echo "$LIST" | awk -v i="$INDEX" -F',' '{print $i}'
}

while [ "$#" -gt 0 ]; do
    case "$1" in
        -i|--interval)
            INTERVAL="$2"
            shift 2
            ;;
        -v|--version)
            echo "no v$VERSION"
            exit 0
            ;;
        -h|--help)
            usage
            ;;
        -r|--random)
            USE_RANDOM=1
            RANDOM_ITEMS="$2"
            shift 2
            ;;
        -c|--count)
            USE_COUNT=1
            shift
            ;;
        -o|--output)
            OUTPUT="$2"
            shift 2
            ;;
        -t|--times)
            TIMES="$2"
            shift 2
            ;;
        -cmd|--command)
            COMMAND="$2"
            shift 2
            ;;
        *)
            TEXT="$1"
            shift
            ;;
    esac
done

i=0
while [ "$TIMES" -eq 0 ] || [ "$i" -lt "$TIMES" ]; do
    if [ -n "$COMMAND" ]; then
        OUT=$(sh -c "$COMMAND")
    elif [ "$USE_RANDOM" -eq 1 ] && [ -n "$RANDOM_ITEMS" ]; then
        OUT=$(pick_random "$RANDOM_ITEMS")
    else
        OUT="$TEXT"
    fi

    if [ "$USE_COUNT" -eq 1 ]; then
        PREFIX="$((i+1)): "
    else
        PREFIX=""
    fi

    if [ -n "$OUTPUT" ]; then
        echo "${PREFIX}${OUT}" >> "$OUTPUT"
    else
        echo "${PREFIX}${OUT}"
    fi

    i=$((i+1))
    awk_exit=$(echo "$INTERVAL > 0" | awk '{exit !$1}')
    if [ "$?" -eq 0 ]; then
        sleep "$INTERVAL"
    fi
done
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
