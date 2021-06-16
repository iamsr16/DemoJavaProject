def ARTI_VER
pipeline {
  agent any
  tools {
        maven 'maven'
  }
  stages {
    stage('Create Version') {
      steps {
        script {
          ARTI_VER = "${BRANCH_NAME}-${BUILD_NUMBER}" 
          echo "${ARTI_VER}"
        }
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
	    script{
           sh "mvn -s settings.xml -Drevision=$ARTI_VER deploy"
	    }
      }
   } 
 }
}
