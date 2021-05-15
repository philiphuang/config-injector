在搭建在项目的时候，经常需要把配置的信息注入到文本文件中。

本项目将.env里面的配置信息，直接注入到MySQL，Docker Compose，SpringBoot等多种配置文件里面，只需两步：
1. 把需要配置的变量写入.evn文件中，并挂在到/.env中；
2. 把各类配置文件的模板逐个挂接到容器里面的/input目录下，模板中要被环境变量替换的内容用${Variable}标注；
3. 把模板的生成结果，挂载到/output/目录下的同名文件；
4. 运行本镜像，即可把.env里面的变量，一次过注入到模板中，并保存到/output目录下的同名文件。需注意的是，挂在到/input的目录结果，和/output的目录结构，必须相同，才可以实现同目录同名文件注入，如果/input中缺少的文件，不会被注入，/input中存在的文件，但文件内容没有。

ps. 请确保有足够权限读、写这些配置文件

docker-compose样例：
```docker-compose
version: '2'

services:

dcstarter-init:
    image: philiphuang/config-injector:latest
    volumes:
      - ./.env:/.env
      - ./config/mysql_init_template:/input/mysql_init
      - ./config/mysql_init:/output/mysql_init
```