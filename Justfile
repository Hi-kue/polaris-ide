#!/usr/bin/env just --justfile

alias c := clean
alias ca := clean-all
alias ct := clean-this
alias b := build
alias r := run

SCRIPT_DIR := "scripts"

# README
# *=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*
# This is the main justfile execution environment 
# for the entire codebase. It's purpose is to make
# it easier to run common tasks such as cleaning
# the codebase, building /sites or /deslib, or any
# other sub-projects that may be added in the near
# future. 
#
# NOTE: In order to be able to use this justfile,
# you must have 'just' installed on your system.
# To install just, simply follow the documentation
# here: https://just.systems/man/en/
#
# Current File: logs.sh
# Commands: info, warn, error, success, debug
# *=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*

# NOTE: Default command (lists all available commands).
default:
	@just --list

# NOTE: Clean specific files in the current project (noted within clean.sh).
[group("Clean Commands")]
[confirm("Are you sure you want to perform a clean? This action cannot be undone.")]
clean:
    @bash {{SCRIPT_DIR}}/clean.sh --clean

# NOTE: Perform a deep clean on the project (removes all unwanted files).
[group('Clean Commands')]
[confirm("Are you sure you want to perform a deep clean? This action cannot be undone.")]
clean-all:
    @bash {{SCRIPT_DIR}}/clean.sh --clean-all

# NOTE: Perform a clean on a specific directory within the project.
[group('Clean Commands')]
[confirm("Are you sure you want to clean this directory? This action cannot be undone.")]
clean-this DIR:
    @bash {{SCRIPT_DIR}}/clean.sh --clean-this {{DIR}}

# NOTE: Clean the project, passing any additional flags/arguments.
[group('Clean Commands')]
[confirm("Are you sure you want to perform a clean? This action cannot be undone.")]
clean-with *ARGS:
    @bash {{SCRIPT_DIR}}/clean.sh {{ARGS}}

# NOTE: Build the entire project (run.sh).
[group('Build Commands')]
build *ARGS: clean
    @bash {{SCRIPT_DIR}}/build.sh {{ARGS}}

# NOTE: Rebuild the entire project (clean, build).
[group('Build Commands')]
rebuild *ARGS: clean
    @bash {{SCRIPT_DIR}}/rebuild.sh {{ARGS}}

# NOTE: Run the project after build clean stages (build.sh, clean.sh).
run *ARGS: clean build
    @bash {{SCRIPT_DIR}}/run.sh {{ARGS}}
