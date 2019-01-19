#!/bin/sh
# 定义原jar位置,新jar文件夹,新jar文件名称
oldJarPath=$1
targetPath=$2 # /opt/simple-java-maven-app/
targetJarName=$3 # my-app.jar

mkdir -p ${targetPath}

#如果指定jar在运行,则杀掉进程
pid=`ps -ef |grep ${targetJarName} |grep -v grep | awk '{print $2}'`
if [ "$pid" != "" ]; then
kill -9 $pid
fi

#清空部署文件夹的文件
rm -f '${targetPath}*'
# 将老的jar复制到要部署的文件夹
cp -f ${oldJarPath} ${targetPath}${targetJarName}
# 后台运行jar
(nohup java -jar '${targetPath}${targetJarName}' >>runtime.log 2>&1 &)&&sleep 1
