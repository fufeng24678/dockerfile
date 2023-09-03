[TOC]

***

# \[ rocketmq-exporter \] 

基于 [![](https://img.shields.io/badge/GitHub-apache/rocketmq--exporter-green?logo=github)](https://github.com/apache/rocketmq-exporter) 项目构建 docker 镜像

该项目 github 地址 ( dockerfile 及构建脚本 ): 

# 可选参数

可选参数在 CMD 中指定，参数前加 `--` 

|               参数               |     默认值     |
| :------------------------------: | :------------: |
|   rocketmq.config.namesrvAddr    | 127.0.0.1:9876 |
| rocketmq.config.rocketmqVersion  |     4_9_4      |
|           server.port            |      5557      |
| rocketmq.config.webTelemetryPath |    /metrics    |

# demo

demo 环境信息

- rocketmqNameSrv: `10.11.12.57:9876;10.11.12.58:9876;10.11.12.59:9876` 
- rocketmqVersion: `4_9_7` 

## docker cli

```shell
docker run -d \
  -p 5557:5557 \
  fufeng24678/rocketmq-exporter:latest \
  --rocketmq.config.namesrvAddr="10.11.12.57:9876;10.11.12.58:9876;10.11.12.59:9876" \
  --rocketmq.config.rocketmqVersion=4_9_7
```

## docker-compose

```shell
version: '3.8'
services:
  rocketmq-exporter:
    image: fufeng24678/rocketmq-exporter:latest
    command: 
    - --rocketmq.config.namesrvAddr="10.11.12.57:9876;10.11.12.58:9876;10.11.12.59:9876"
    - --rocketmq.config.rocketmqVersion=4_9_7
    restart: always
    ports:
    - 5557:5557
    volumes:
    - /usr/share/zoneinfo/Asia/Shanghai:/etc/localtime:ro
```

