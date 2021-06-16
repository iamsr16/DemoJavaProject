def ARTI_VER
def GIT_BRANCH
pipeline {
  agent any
  tools {
        maven 'maven'
  }
  stages {
    stage('Create Version') {
      steps {
        script { 
		  GIT_BRANCH = "${BRANCH_NAME}-${BUILD_NUMBER}"
		  ARTI_VER = sh(returnStdout: true, script: "echo $GIT_BRANCH | sed 's@/@-@g'").trim()
        }
		sh 'echo $ARTI_VER'
		sh 'echo $GIT_BRANCH'
      }
    }
//    stage('Build') {
//      steps {
//        sh 'mvn -s settings.xml package '
//      }
//    }
//	stage('Publish test and Code Coverage') {
//      steps {
//        junit allowEmptyResults: true, skipPublishingChecks: true, 
//				testResults: 'target/surefire-reports/*.xml'
//		publishCoverage adapters: [jacocoAdapter('target/site/jacoco/jacoco*.xml')], 
//						sourceFileResolver: sourceFiles('NEVER_STORE')
//      }
//   }
   stage('Deploy to nexus') {
      steps {
		sh 'echo $ARTI_VER'
		sh 'echo $GIT_BRANCH'
        sh 'mvn -s settings.xml -Drevision=$ARTI_VER deploy '
      }
   } 
 }
}
