FROM ubuntu:22.04

# DESCRIPTION "更改时区，替换apk源为USTC"
LABEL MAINTAINER=yangrui
LABEL ubuntu_version=22.04
LABEL zoneinfo="Asia/Shanghai"
LABEL apt_repositoris="mirrors.ustc.edu.cn"

RUN sed -i 's/archive.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y  tzdata ca-certificates curl  && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo "Asia/Shanghai" > /etc/timezone