def ARTI_VER
def appImage
pipeline {
	environment {
        registry = "rahulyerme1234/user-app"
        registryCredential = 'dockerhub'
        }
  agent any
  tools {
    maven 'Apache Maven 3.8.6'
  }
  stages {
    stage('Create Version') {
      steps {
        script {
          ARTI_VER = "${env.GIT_BRANCH}-${env.BUILD_NUMBER}"
          echo "${ARTI_VER}"
        }
      }
    }
    stage('Build') {
      steps {
		script {
          sh "mvn clean package"
        }
      }
    }

 }
}
