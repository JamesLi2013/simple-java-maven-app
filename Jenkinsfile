node {
   def mvnHome
 
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
      archiveArtifacts   artifacts: 'target/*.jar',
      def jarPath='target/my-app*.jar'
      def targetPath='/opt/simple-java-maven-app/my-app.jar'
      //sh "mkdir -p ${targetPath}"
      // stop old jar and so on
      sh "rm -f '${targetPath}'"
      sh "cp -f ${jarPath} ${targetPath}"
      sh "java -jar ${targetPath}"
      sh "echo '完成了~'"
   }

   stage('after echo'){
       sh "echo '----------------end-------------'"
   }
}
