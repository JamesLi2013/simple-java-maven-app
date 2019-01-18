node {
   def mvnHome
   stage('Preparation') { // for display purposes
      // Get some code from a GitHub repository
      //git 'https://github.com/JamesLi2013/simple-java-maven-app.git'
      // Get the Maven tool.
      // ** NOTE: This 'M3' Maven tool must be configured
      // **       in the global configuration.           
      mvnHome = '/opt/soft/apache-maven-3.6.0'
      // Make the output directory.
    sh "mkdir -p output"

    // Write an useful file, which is needed to be archived.
    writeFile file: "output/usefulfile.txt", text: "This file is useful, need to archive it."

    // Write an useless file, which is not needed to be archived.
    writeFile file: "output/uselessfile.md", text: "This file is useless, no need to archive it."
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
      archiveArtifacts   artifacts: 'target/*.jar', excludes: 'output/*.md'
      sh "java -jar '/home/lqx/.jenkins/jobs/simple-java-maven-app/builds/lastSuccessfulBuild/archive/target/my-app-1.0-SNAPSHOT.jar'"
      sh "echo '完成了~'"
   }
}
