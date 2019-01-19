node {
   def mvnHome
   if(deployType=='rollback'){
          //由于当前回滚版本号已自增1,因此原上个版本号需在当前基础上-2
          int lastVersion = Integer.parseInt(BUILD_NUMBER)-2
          def lastVersionStr=lastVersion.toString()
          def jarPath
          def targetPath='/opt/simple-java-maven-app/'
          def targetJarName='my-app.jar'
          //version为0时,回滚到上个版本,否则,回滚到指定版本
          if(version=='0'){
            jarPath='/home/lqx/.jenkins/jobs/simple-java-maven-app/builds/'+lastVersionStr+'/archive/target/my-app*.jar'
          }else{
            jarPath='/home/lqx/.jenkins/jobs/simple-java-maven-app/builds/${version}/archive/target/my-app*.jar'
            lastVersionStr=version
          }

          sh "mkdir -p ${targetPath}"
          // 停止原来的jar包
          //ps -ef | grep ${targetJarName} | grep -v grep|awk '{print $2}' |xargs kill -9 ||echo$?
          //def lines = sh(script: 'dumpStuff.sh', returnStdout: true)
          sh "rm -f '${targetPath}*'"
          sh "cp -f ${jarPath} '${targetPath}${targetJarName}'"
          //后台执行jar
          sh "(nohup java -jar '${targetPath}${targetJarName}' >>runtime.log 2>&1 &)&&sleep 1"
          sh "echo '---完成回滚,回滚版本号:${lastVersionStr} ---'"
        return;
   }
   stage('Preparation') { // for display purposes
   sh "echo ${deployType}"
   sh "echo ${version}"
   sh "git pull origin master"
      mvnHome = '/opt/soft/apache-maven-3.6.0'

   }
   stage('Build') {
      // Run the maven build
      if (isUnix()) {
         sh "'${mvnHome}/bin/mvn' clean package -Dmaven.test.skip=true"
      } else {
         bat(/"${mvnHome}\bin\mvn" -Dmaven.test.failure.ignore clean package/)
      }
  
   }
   stage('Results') {
      //junit '**/target/surefire-reports/TEST-*.xml'
      archiveArtifacts   artifacts: 'target/*.jar'
      def jarPath='target/my-app*.jar'
      def targetPath='/opt/simple-java-maven-app/my-app.jar'
      //sh "mkdir -p ${targetPath}"
      // stop old jar and so on
      String pid=sh(script:"ps -ef | grep mysql | grep -v grep", returnStdout: true)
      println(pid);
      //sh "echo '${pid}'"
      if(pid!=null&&!"".equals(pid.trim())){
        pid=pid.split("\\s+")[1];
        sh "kill 9 ${pid}"
      }
      sh "rm -f '${targetPath}'"
      sh "cp -f ${jarPath} ${targetPath}"
      sh "java -jar ${targetPath}"
      sh "echo '完成了~'"
   }

   stage('after echo'){
       sh "echo '----------------end-------------'"
   }
}
