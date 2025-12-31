#!/bin/sh
# Author: ihatemustard
# Flexible "no" command

times=-1
word="n"

# Parse arguments
while [ $# -gt 0 ]; do
    case "$1" in
        --times)
            shift
            times="$1"
            ;;
        *)
            word="$1"
            ;;
    esac
    shift
done

print_word() {
    echo "$word"
}

if [ "$times" -eq -1 ]; then
    while true; do
        print_word
    done
else
    i=0
    while [ $i -lt "$times" ]; do
        print_word
        i=$((i + 1))
    done
fi
