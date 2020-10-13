#!/usr/bin/env bash

function outter_fn {
    inner_fn() {
        echo "inner_fn -> hello $1"
    }

    ret=$(inner_fn "from the inside")

    echo -e "\noutter_fn -> hello $1\n${ret}\n"

    # unset to not pollute global variable space
    unset -f inner_fn
}


function run_if_executable_available {
    executable_name=$1
    # hash: https://www.computerhope.com/unix/bash/hash.htm
    if hash "${executable_name}" 2> /dev/null; then
		cmd="${executable_name}";
        msg="${executable_name} found in path"
	else
        msg="${executable_name} not found in path"
	fi;
    echo "run_if_executable_available(\"${executable_name}\"): ${msg}"
}

function main {
    outter_fn "from the outside"
    run_if_executable_available ls
}

main "$@"
