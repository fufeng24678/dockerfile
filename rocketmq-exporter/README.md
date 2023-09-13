[TOC]

***

基于 [![](https://img.shields.io/badge/GitHub-apache/rocketmq--exporter-green?logo=github)](https://github.com/apache/rocketmq-exporter) 项目构建 docker 镜像

该项目 github 地址 ( dockerfile 及构建脚本 ): https://github.com/fufeng24678/dockerfile/tree/main/rocketmq-exporter 

# 可选参数

可选参数在 CMD 中指定，参数前加 `--` 

|               参数               |     默认值     |                 描述                  |
| :------------------------------: | :------------: | :-----------------------------------: |
|   rocketmq.config.namesrvAddr    | 127.0.0.1:9876 |  nameSrv 地址，多个地址使用分号分隔   |
| rocketmq.config.rocketmqVersion  |     4_9_4      | rocketmq 版本，建议与实际使用版本对应 |
|           server.port            |      5557      |           metrics 暴露端口            |
| rocketmq.config.webTelemetryPath |    /metrics    |             metrics path              |

# Demo

demo 环境信息

- rocketmqNameSrv: `10.11.12.57:9876;10.11.12.58:9876;10.11.12.59:9876` 
- rocketmqVersion: `4_9_7` 

## docker-cli 启动

```shell
docker run -d \
  --name=rocketmq-exporter \
  --restart=always \
  -p 5557:5557 \
  fufeng24678/rocketmq-exporter:latest \
  --rocketmq.config.namesrvAddr="10.11.12.57:9876;10.11.12.58:9876;10.11.12.59:9876" \
  --rocketmq.config.rocketmqVersion=4_9_7
```

## docker-compose 启动

资源清单地址: https://github.com/fufeng24678/docker-compose/tree/main/rocketmq-exporter 

```yaml
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

# Prometheus 发现配置

```yaml
scrape_configs:
- job_name: "rocketmq-03"
  static_configs:
  - targets:
    - 10.11.12.59:5557
    labels:
      hostname: rocketmq-03
  # file_sd_configs:
  # - files:
  #   - /etc/prometheus/file_sd/redis.yaml
  metric_relabel_configs:
  - source_labels:
    - __name__
    regex: "go_.*"
    action: drop
```

# Grafana 面板推荐

- 14612
- 10477
