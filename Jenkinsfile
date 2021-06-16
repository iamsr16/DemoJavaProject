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
    stage('Build') {
      steps {
        sh 'mvn install '
      }
    }
	stage('Publish test') {
      steps {
        junit allowEmptyResults: true, skipPublishingChecks: true, 
				testResults: 'target/surefire-reports/*.xml'
      }
    }
  }
}
