#!/bin/sh
# 定义原jar位置,新jar文件夹,新jar文件名称
oldJarPath=$1
targetPath=$2 # /opt/simple-java-maven-app/
targetJarName=$3 # my-app.jar

mkdir -p ${targetPath}

#如果指定jar在运行,则杀掉进程.输入参数多了2行如下信息,也需要去除.
#lqx 6114 7730 0 14:38 pts/0 00:00:00 /bin/sh ./temp.sh target/my-app*.jar /opt/simple-java-maven-app/ my-app.jar
pid=`ps -ef |grep ${targetJarName} |grep -v grep |grep -v  ${targetPath} | awk '{print $2}'`
if [ "$pid" != "" ]; then
kill -9 $pid
fi

#清空部署文件夹的文件
rm -f '${targetPath}*'
# 将老的jar复制到要部署的文件夹
cp -f ${oldJarPath} ${targetPath}${targetJarName}
# 后台运行jar
java -jar '${targetPath}${targetJarName}'
#(nohup java -jar '${targetPath}${targetJarName}' >>runtime.log 2>&1 &)&&sleep 1
