# build docker images

Use alpine:3.15 as the base image,

replace apk repo (mirrors.ustc.edu.cn),
change the time zone ("Asia/Shanghai"),
and Add glibc-2.35

+ build command:

> docker build  -f Dockerfile.alpine -t alpine:3.15-glibc .
