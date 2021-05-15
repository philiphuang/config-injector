#!/bin/sh

# 读入环境变量
# set -x

set -a
source ./.env
set +a

# env

# 设置目录
input_dir="/data/projects/mytools/image-factory/unitest/inject"
output_dir="/data/projects/mytools/image-factory/unitest/output"

for template_file in ${input_dir}/*.template
do
    filename=$(basename ${template_file} .template)
    dest_file=${output_dir}/${filename}
    envsubst < "${template_file}" > "${dest_file}"
done
# set +x