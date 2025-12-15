#!/usr/bin/env bash

function guess_image() {
    local image="${1}"

    image="${image// /}"
    image="${image#\/}"
    image="${image%\/}"

    if [[ -z "${image}" ]]; then
        return
    fi
    
    # 检查是否包含逗号分割的版本
    if [[ "${image}" == *","* ]]; then
        # 提取基础镜像名（第一个冒号前的部分）
        base_image=$(echo "${image}" | awk -F':' '{print $1}')
        # 提取版本字符串（第一个冒号后的部分）
        versions=$(echo "${image}" | awk -F':' '{print substr($0, index($0, ":") + 1)}')
        
        # 验证基础镜像名格式
        if [[ "${base_image}" == *"//"* ]] || [[ "${base_image}" == *" "* ]]; then
            return
        fi
        
        # 验证版本字符串格式
        if [[ "${versions}" == *"//"* ]] || [[ "${versions}" == *" "* ]]; then
            return
        fi
        
        echo "${image}"
        return
    fi
    
    # 处理单版本情况
    if [[ "${image}" != *":"* ]]; then
        image="${image}:latest"
    fi
    if [[ "${image}" == *"//"* ]] || [[ "${image}" == *" "* ]]; then
        return
    fi

    echo "${image}"
}

guess_image "${1}"
