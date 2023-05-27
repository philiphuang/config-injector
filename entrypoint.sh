#!/bin/sh
# 读入环境变量
if [ -f "/.env" ]; then
    set -a
    . /.env
    set +a
fi

if [ 1 -eq $DEBUG ]; then
    echo "DEBUG mode on"  # 打印调试信息
    set -x  # 打开调试跟踪
    env
fi

# 设置目录
input_dir=/input
output_dir=/output

read_dir(){
    for file in $1/*
    do
        if [ -d "$file" ]
        then
            read_dir "${file}" 
        else
            inject_file "${file}"
        fi
    done
}

inject_file(){
    # ${VAR#*STR} 这是BASH替换字符串的语法，搜索bash 字符串截取
    # dest_file=${output_dir}"/"${1#*$(echo $input_dir)}
    relative_path=${1#"$input_dir"}
    dest_file=${output_dir}$relative_path
    mkdir -p "$(dirname $dest_file)"
    cp -a "$1" "${dest_file}"
    envsubst < "$1" > "${dest_file}"; 
}

read_dir $input_dir
if [ $? -eq 0 ] ; then echo injection succeeded!! ; else echo injection failed!!; fi
set +x
