#!/usr/bin/env bash

this_script_name=`basename "$0"`
this_script_directory_path="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

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
    echo -e "run_if_executable_available(\"${executable_name}\"): ${msg}\n"
}

function file_size {
    file=$1
    size_in_bytes=$(stat -f"%z" "${file}")

    echo -e "${file} is ${size_in_bytes} bytes\n"
}

function this_script_paths {
    echo -e "this_script_name: ${this_script_name}\n"
    echo -e "this_script_directory_path: ${this_script_directory_path}\n"
}

function to_lowercase {
    echo "$@" | tr '[:upper:]' '[:lower:]'
}

function to_lowercase_example {
    input="HELLO WorlD"
    ret=$(to_lowercase "${input}")
    echo -e "to_lowercase_example: to_lowercase(\"${input}\") -> ${ret}\n"

}

# output: 2020-10-12_14-36-11
function timestamp_string {
    date +"%Y-%m-%d_%H-%M-%S"
}

# output: 1602527794
function timestamp_unix {
    date +%s
}

# output: 20201012
function date_year_month_day {
    date "+%Y%m%d"
}

function date_time_examples {
    echo -e "timestamp_string: $(timestamp_string)"
    echo -e "timestamp_unix: $(timestamp_unix)"
    echo -e "date_year_month_day: $(date_year_month_day)\n"
}

function environment_variable_exists_example {

    variable_name=$1

    # https://stackoverflow.com/questions/16553089/dynamic-variable-names-in-bash
    variable_value="${!variable_name}" # ! for dynamic variable name


    if [ ! -z "${variable_value}" ]; then
        echo -e "variable_name: ${variable_name}\nvariable_value: ${variable_value}\n"
    else
        echo -e "variable_name \"${variable_name}\" not defined\n"
    fi
}

function prompt_for_input_example {
    # zsh specific
    echo -e "Enter some text: "
    read REPLY
    echo -e "You entered ${REPLY}\n"
}

function main {
    this_script_paths
    outter_fn "from the outside"
    run_if_executable_available ls
    file_size "${this_script_name}"
    date_time_examples
    to_lowercase_example

    environment_variable_exists_example "SHELL"
    environment_variable_exists_example "SHELLzzz"

    #prompt_for_input_example
}

main "$@"