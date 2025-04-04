#!/usr/bin/env bash

detect_os() {
    case "$OSTYPE" in
        solaris*) echo "solaris" ;;
        darwin*)  echo "macos" ;;
        linux*)   echo "linux" ;;
        bsd*)     echo "bsd" ;;
        msys* | cygwin*) echo "windows" ;;
        *)        echo "unknown" ;;
    esac
}

echo "You are on $(detect_os)"

