#!/bin/bash
# 不要改变下行的位置，保持在脚本开头
APP_PATH=$(cd $(dirname ${BASH_SOURCE:-$0}); pwd)
source "${APP_PATH}/launcher/default.sh"

########## 以下是可修改的内容 ##########
PROXY="http://127.0.0.1:3128/"
NOPROXY="localhost,127.0.0.1"
# export no_proxy="${NOPROXY},192.168.0.200,192.168.0.100,192.168.0.101,10.244.0.0/16"

# 项目标记符
PROJECT_NAME="building_kit"

# 容器名称
CONTAINER_LIST_TEXT="${DEFAULT_CONTAINER_LIST_TEXT}
testsuit
"

# 操作清单，从第七项开始
ACTION_LIST_TEXT="${DEFAULT_ACTION_LIST_TEXT}
test
"

# 是否允许以root身份运行
ALLOW_ROOT=true

DCC_COMMAND="docker-compose -p ${PROJECT_NAME} -f docker-compose.yml"

CONTAINER_PREFIX="${PROJECT_NAME}-"
BACKUP_CONTAINER="${PROJECT_NAME}-backups"

MYSQL_CONTAINER="${PROJECT_NAME}-mysql"
MYSQL_USER="root"
MYSQL_PWD=""

# 容器启动时需要建立的外部网络
NETWORK_LIST=""

func7(){
    # echo "function 7"
    ${DCC_COMMAND} run testsuit
    # ${DCC_COMMAND} logs testsuit
}

########## 以上是可修改的内容 ##########

# 不要改变下行的位置，保持在脚本结尾
[ -n "${1}" ] && source "${APP_PATH}/${1}"
go