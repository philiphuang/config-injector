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
            inject_config "${file}"
        fi
    done
}

inject_config(){
    # 找出当前路径位于input目录下的差距
    relative_path=${1#"$input_dir"}
    # 构建output路径下的全路径
    dest_file=${output_dir}$relative_path
    # 确保目录存在
    mkdir -p "$(dirname $dest_file)"
    # 用cp -a保证目标文件和源文件属性一致
    cp -a "$1" "${dest_file}"
    # 替换目标文件的内容
    envsubst < "$1" > "${dest_file}"; 
}

read_dir $input_dir
if [ $? -eq 0 ] ; then echo injection succeeded!! ; else echo injection failed!!; fi
set +x
