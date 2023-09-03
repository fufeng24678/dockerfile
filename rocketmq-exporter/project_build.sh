#!/bin/bash

set -eux
cd "$(dirname "$0")"

GIT_URL="https://github.com/apache/rocketmq-exporter.git"
GIT_BRANCH="master"
PROJECT_DIR="src"
BUILD_IMAGE="maven:3.8.6-openjdk-11"

# 清理项目目录
rm -rf "$PROJECT_DIR"
mkdir -p "$PROJECT_DIR"
cd "$PROJECT_DIR"
# 拉取源代码
git init
git config --local http.sslVerify false
git remote add origin "$GIT_URL"
git pull origin "$GIT_BRANCH"
git log -n 1
cd ..

# 修改 bug
sed -i.bak -r \
    -e "s/getTransferredTps/getTransferedTps/g" \
    src/src/main/java/org/apache/rocketmq/exporter/model/BrokerRuntimeStats.java

# 编译项目
docker run --rm \
    --network=host \
    --workdir=/"$PROJECT_DIR" \
    -v /opt/tmp/maven_localrepo:/root/.m2 \
    -v "$(pwd)"/"$PROJECT_DIR":/"$PROJECT_DIR" \
    --entrypoint=/bin/bash \
    "$BUILD_IMAGE" -c "mvn clean package -Dmaven.test.skip=true"

# rm -rf *.jar *.yml

# cp -a ./src/"$PROJECT_DIR"/target/*-exec.jar ./
# cp -a ./src/"$PROJECT_DIR"/src/main/resources/application.yml ./
