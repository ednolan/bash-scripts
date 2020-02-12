#!/bin/bash

# taken from https://blog.codecentric.de/en/2019/06/good-password/

declare HELP="\
pwned_password.sh - Print how many times a password appears in HIBP's passwords API

SYNOPSIS
    ./pwned_password.sh [OPTIONS]

OPTIONS
    -h, --help Print this message
"

set -e

function main()
{
    # Parse options
    OPT_RESULTS=$(getopt -o 'h' -a --longoptions 'help' -n 'pwned_password.sh' -- "$@")
    [[ $? -eq 0 ]] || exit 1
    eval set -- "$OPT_RESULTS"
    while [[ $# -ne 0 ]] ; do
        case "$1" in
            --) shift; break ;;
            -h|--help)
                echo "$HELP"
                exit 0 ;;
            *) exit 1 ;;
        esac
    done
    read -p "Enter password: " -s password
    echo
    local password_hash=$(echo -n "$password" | openssl sha1 | cut -d' ' -f2)
    local password_hash_prefix=$(echo $password_hash | cut -b-5)
    local curl_tempfile=$(mktemp)
    curl "https://api.pwnedpasswords.com/range/$password_hash_prefix" 2>/dev/null > $curl_tempfile
    local password_hash_suffix=$(echo $password_hash | cut -b6-)
    set +e
    local grep_result=$(grep -i $password_hash_suffix $curl_tempfile) grep_code=$?
    if [[ $grep_code -eq 1 ]] ; then
        echo "0"
        rm $curl_tempfile
        exit 0
    fi
    set -e
    echo $grep_result | cut -d':' -f2
    rm $curl_tempfile
    exit 1
}

main "$@"
