#!/usr/bin/env bash

function outter_fn {
    inner_fn() {
        echo "inner_fn -> hello $1"
    }

    ret=$(inner_fn "from the inside")

    echo -e "\noutter_fn -> hello $1\n${ret}"

    # unset to not pollute global variable space
    unset -f inner_fn
}

function main {
    outter_fn "from the outside"
}

main "$@"
