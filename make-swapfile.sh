#!/bin/bash

as_root() {
  if [ "$EUID" -ne 0 ]; then
    echo ""
    echo " ❌  Run as root."
    echo " ℹ️  Usage: sudo $0"
    echo ""
    exit 1
  fi
}


check_if_linux() {
    if [ "$(uname)" != "Linux" ]; then
        echo "This script is intended for Linux only."
        exit 1
    fi
}


create_swap_file() {
    printf "\n\n\n"
    printf "Creating a 8GB swap file at /tmp/swap.file\n"
    printf "This may take a few minutes...\n"
    dd if=/dev/zero of=/tmp/swap.file bs=1M count=8192
} 


setup_swap_file() {
    printf "\n\n\n"
    printf "Setting up the swap file...\n"
    chmod 0600 /tmp/swap.file

    mkswap /tmp/swap.file

    swapon /tmp/swap.file
} 


main() {
    as_root
    check_if_linux
    create_swap_file
    setup_swap_file
    printf "\n\n\n"
    printf "Swap file created and activated.\n"
}


main