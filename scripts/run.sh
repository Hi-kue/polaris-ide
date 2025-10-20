#!/usr/bin/env bash

# README
# *=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*
# This script provides a convenient way to run the
# dev server with proper checks and validation 
# including but not limited to the following:
# - linting;
# - formatting;
# - starting the server.
# 
# The purpose of this script is to avoid running
# constant commands manually (like npm run lint,
# npm run format, npm run start) and to make sure
# the dev server starts after the lint, formating, 
# and eventually tests are successful.
#
# NOTE:
# Customize the RUN_STEPS array to whatever
# steps you want to include in the run process,
# and in the order you want them to be executed.
#
# Current File: run.sh
# Commands: --lint-only | -l, --format-only | -f, --start-only | -s, --help
# *=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../scripts" && pwd)"
source "$SCRIPT_DIR/logs.sh"

set -e

warn "Before starting this project, ensure that you have at least built the project once."

declare -a RUN_STEPS=(
    "lint"
    "format"
    "dev"
)

show_help() {
    echo "Usage: $0 [options]"
    echo ""
    echo "Options:"
    echo "  --lint-only, -l       Run only the linting step."
    echo "  --format-only, -f     Run only the formatting step."
    echo "  --dev-only, -d        Run only the development server start step."
    echo "  --help                Show this help message and exit."
    echo ""
    echo "If no options are provided, all steps (lint, format, start) will be executed in order."
}

run_lint() {
    info "Running linting step..."
    npm run lint
}

run_format() {
    info "Running formatting step..."
    npm run format
}

run_dev() {
    info "Running development server start step..."
    npm run dev
}

run_all() {
    run_lint
    run_format
    run_dev
}

if [[ $# -eq 0 ]]; then
    run_all
    exit 0
fi

while [[ $# -gt 0 ]]; do
    case $1 in
        --lint-only|-l)
            run_lint
            exit 0
            ;;
        --format-only|-f)
            run_format
            exit 0
            ;;
        --dev-only|-d)
            run_dev
            exit 0
            ;;
        --help)
            show_help
            exit 0
            ;;
        *)
            error "Unknown option provided: $1"
            show_help
            exit 1
            ;;
    esac
    shift
done

success "All steps from RUN_STEPS completed successfully, happy coding!"
