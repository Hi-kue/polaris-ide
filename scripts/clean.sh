#!/usr/bin/env bash

# README
# *=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*
# This script cleans up all the files and directories
# that are commonly generated during development. It 
# is useful for maintaining a tidy working environment
# or just giving the entire codebase a fresh batch of
# paint to get back to a clean state.
#
# NOTE:
# Customize the DEEP_CLEAN_DIRS and DEEP_CLEAN_FILES
# arrays to whatever you want to be removed during
# your fresh starts.
#
# Current File: clean.sh
# Commands: 
#   --clean-all, -ca            Perform deep clean on the codebase.
#   --clean, -c                 Perform partial clean on the codebase.
#   --clean-this, -ct <dir>     Perform clean on a specific directory/folder.
#   --help                      Show a help message for anyone who is new to the script.
# *=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../scripts" && pwd)"
source "$SCRIPT_DIR/logs.sh"

set -e

declare -a DEEP_CLEAN_DIRS=(
    "node_modules",
    ".next",
    "dist",
    "build",
    ".cache",
    ".tmp"
)

declare -a DEEP_CLEAN_FILES=(
    "package-lock.json",
    "yarn.lock",
    "pnpm-lock.yaml",
    "*.log",
    "*.tmp",
    "*.bak"
)

show_help() {
    echo "Usage: $0 [options]"
    echo ""
    echo "Options:"
    echo "  --clean-all, -ca            Perform deep clean on repository (removes all unwanted files.)"
    echo "  --clean, -c                 Perform partial clean on repository (removes file within the current specific directory.)"
    echo "  --clean-this, -ct <dir>     Perform clean on a specific directory."
    echo "  --help                      Show a help message for anyone who wants to understand the script usage."
}


deep_clean() {
    if [ -n "$1" ]; then
        info "Passed directory with function: $1... Cleaning all files within $1."

        for dir in "${DEEP_CLEAN_DIRS[@]}"; do
            find "$1" -name "$dir" -type d -prune -print -exec rm -rf '{}' \;
        done

        for file in "${DEEP_CLEAN_FILES[@]}"; do
            find "$1" -name "$file" -type f -print -exec rm -f '{}' \;
        done
    else
        info "No flag passed, performing deep clean on the current directory."

        for dir in "${DEEP_CLEAN_DIRS[@]}"; do
            find "." -name "$dir" -type d -prune -print -exec rm -rf '{}' \;
        done

        for file in "${DEEP_CLEAN_FILES[@]}"; do
            find "." -name "$file" -type f -print -exec rm -f '{}' \;
        done
    fi
}

clean() {
    info "Cleaning all files in the current directory..."
    for file in "${DEEP_CLEAN_FILES[@]}"; do
        info "Removing files matching: $file"
        find "." -maxdepth 2 -name "$file" -type f -exec rm -f '{}' + 2>/dev/null || true
    done
}

if [[ "$#" -eq 0 ]]; then
    show_help
    exit 0
fi

while [[ "$#" -gt 0 ]]; do
    case $1 in
    --clean-all | -ca) 
        info "Performing deep clean on repository... This might take a while."
        deep_clean
        shift
        ;;
    --clean | -c)
        info "Performing partial clean on repository... This will only clean specific files"
        clean
        shift
        ;;
    --clean-this | -ct)
        if [ -z "$2" ]; then
            error "Error: No directory flag was passed while performing --clean-this. Skipping."
            show_help
            exit 1
        fi
        info "Performing deep clean on the following dir: $2... This might take a while."
        deep_clean "$2"
        shift
        ;;
    -*)
        error "Error, Unknown option provided, got: $1"
        show_help
        exit 1
        ;;  
    *)
        error "Error, Invalid argument was passed, got: $1"
        show_help
        exit 1
    esac
done

success "Clean script has completed successfully. Happy coding!"
