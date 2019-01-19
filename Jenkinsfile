node {
    def mvnHome
    def targetPath = '/opt/simple-java-maven-app/'
    def targetJarName = 'my-app.jar'
    def jarPath
    sh "echo '部署方法:${deployType},传入的版本号:${version}'"
    if (deployType == 'rollback') {//deployType值默认是deploy,进行新部署,rollback进行回滚
        //由于当前回滚版本号已自增1,因此原上个版本号需在当前基础上-2
        int lastVersion = Integer.parseInt(BUILD_NUMBER) - 2
        def lastVersionStr = lastVersion.toString()
        //version为0时,回滚到上个版本,否则,回滚到指定版本
        if (version == '0') {
            jarPath = '/home/lqx/.jenkins/jobs/simple-java-maven-app/builds/' + lastVersionStr + '/archive/target/my-app*.jar'
        } else {
            jarPath = '/home/lqx/.jenkins/jobs/simple-java-maven-app/builds/${version}/archive/target/my-app*.jar'
            lastVersionStr = version
        }
        sh "chmod +x app.sh"
        sh "./app.sh '${jarPath}' ${targetPath} ${targetJarName}"
        sh "echo '完成回滚,回滚版本号:${lastVersionStr}'"
        return
    }
    stage('Preparation') {
        sh "rm -f app.sh" //由于sh文件centos和windows本地不一致,导致服务器上总提示该文件已被修改
        sh "git pull origin master"
        mvnHome = '/opt/soft/apache-maven-3.6.0'
    }
    stage('Build') {
        // maven 编译
        if (isUnix()) {
            sh "'${mvnHome}/bin/mvn' clean package -Dmaven.test.skip=true"
        } else {
            bat(/"${mvnHome}\bin\mvn" clean package -Dmaven.test.skip=true/)
        }

    }
    stage('Results') {
        archiveArtifacts artifacts: 'target/*.jar'
        jarPath = 'target/my-app*.jar'
        sh "chmod +x app.sh"
        sh "./app.sh '${jarPath}' '${targetPath}' ${targetJarName}"
        sh "echo '新版本完成部署'"
    }
}
