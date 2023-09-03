FROM openjdk:11

COPY ./src/target/rocketmq-exporter-*-exec.jar /app/rocketmq-exporter.jar

EXPOSE 5557

WORKDIR /app

ENTRYPOINT [ "java", "-Xmx256m", "-jar", "rocketmq-exporter.jar" ]

###
# 构建命令 ( 先执行 peoject_build.sh 脚本编译项目 )
#   docker build --network=host -t fufeng24678/rocketmq-exporter:20230426 ./
###
# 临时运行 ( 多个 nameserver 使用 ; 符号分隔, 使用分号必须使用双引号括起, rocketmq 版本必须对应 )
#   docker run -it --rm -p 5557:5557 fufeng24678/rocketmq-exporter:20230426 --rocketmq.config.namesrvAddr="10.11.12.57:9876;10.11.12.58:9876;10.11.12.59:9876" --rocketmq.config.rocketmqVersion=4_9_7
###
