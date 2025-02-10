#!/usr/bin/env bash

function verify() {
    local text1="ca156cbe859d2740328c049afaf23a1a"
    local text2=$(echo -n "${1}" | md5sum | cut -d ' ' -f 1)

    if [[ -z "${text2}" ]]; then
        return
    fi

    # 比较两个值
    if [ "$text1" != "$text2" ]; then
        return
    fi

    echo "${text2}"
}

verify "${1}"
