#!/bin/sh
# set -x

# 读入环境变量
set -a
source /.env
set +a

# 查看读入效果
# env

# 设置目录
input_dir="/input"
output_dir="/output"

function read_dir(){
    for file in $(ls "$1")       #注意此处这是两个反引号，表示运行系统命令
    do
        if [ -d "$1/$file" ]  #注意此处之间一定要加上空格，否则会报错
        then
            read_dir "$1/${file}"
        else
            inject_file "$1/${file}"   #处理文件
        fi
    done
}

function inject_file(){
    # ${VAR#*STR} 这是BASH替换字符串的语法，搜索bash 字符串截取
    dest_file=${output_dir}"/"${1#*$(echo $input_dir)}
    if [ -f "${dest_file}" ]; then envsubst < "$1" > "${dest_file}"; fi
}

read_dir $input_dir
if [ $? -eq 0 ] ; then echo injection succeeded!! ; else echo injection failed!!; fi
# set +x
