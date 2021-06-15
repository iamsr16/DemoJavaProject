def ARTI_VER
pipeline {
  agent any
  stages {
    stage('Create Version') {
      steps {
        script {
          ARTI_VER = "${BRANCH_NAME}-${BUILD_NUMBER}" 
          echo ${ARTI_VER}
        }
      }
    }

  }
}
