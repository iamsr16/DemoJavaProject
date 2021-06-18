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
        sh 'mvn -s settings.xml package'
      }
    }
    stage('Publish test and Code Coverage') {
      steps {
        junit allowEmptyResults: true, skipPublishingChecks: true,
          testResults: 'target/surefire-reports/*.xml'
        publishCoverage adapters: [jacocoAdapter('target/site/jacoco/jacoco*.xml')],
          sourceFileResolver: sourceFiles('NEVER_STORE')
      }
    }
    stage('Local artifact archive') {
      steps {
        archive 'target/app*.war'
      }
    }
    stage('Deploy to nexus') {
      steps {
        script {
          sh "mvn -s settings.xml -Drevision=$ARTI_VER deploy"
        }
      }
    }
   stage('build and push docker image') {
      steps {
        script {
          def appImage = docker.build("vaibhavprajapati12/userapis:${BUILD_NUMBER}", "./Dockerfile")
		  appImage.push()
        }
      }
    }
  }
  post {
    success {
      office365ConnectorSend color: '#00cc00', message: "Success  ${JOB_NAME} build_number:${BUILD_NUMBER}, branch:${BRANCH_NAME} url:(<${BUILD_URL}|Open>)", status: 'SUCCESS', webhookUrl: 'https://nitoronline.webhook.office.com/webhookb2/1ecbc1fb-711d-4e7e-831d-8411f0f884ba@8c3dad1d-b6bc-4f8b-939b-8263372eced6/JenkinsCI/7090806d7110469b8fd9bb9fae47c3f3/ffd415cf-de42-4a1f-a127-7c9a0d3c12af'
    }
    failure {
      office365ConnectorSend color: '#fc2c03', message: "Failed  ${JOB_NAME} build_number:${BUILD_NUMBER}, branch:${BRANCH_NAME} url:(<${BUILD_URL}|Open>)", status: 'FAILED', webhookUrl: 'https://nitoronline.webhook.office.com/webhookb2/1ecbc1fb-711d-4e7e-831d-8411f0f884ba@8c3dad1d-b6bc-4f8b-939b-8263372eced6/JenkinsCI/7090806d7110469b8fd9bb9fae47c3f3/ffd415cf-de42-4a1f-a127-7c9a0d3c12af'
    }
  }
}