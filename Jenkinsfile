def ARTI_VER
def appImage
pipeline {
	environment {
        registry = "rahulyerme1234/user-app"
        registryCredential = 'dockerhub'
        }
  agent any
  tools {
    maven 'D:\software\apache-maven-3.8.6'
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
        archiveArtifacts artifacts : 'target/app*.war'
      }
    }
    stage('Deploy to nexus') {
      steps {
              nexusArtifactUploader artifacts:
		    [
			    [artifactId: 'app', 
			     classifier: '', 
			     file: 'target/app-SNAPSHOT.war', 
			     type: 'war']], 
		    credentialsId: 'newnexus', 
		    groupId: 'com.app', 
		    nexusUrl: '192.168.33.10:8081', 
		    nexusVersion: 'nexus3',
		    protocol: 'http', 
		    repository: 'userrepo', 
		    version: '-SNAPSHOT'
      }
    }
    stage('build docker image') {
      steps {
        script {
		  
            appImage = docker.build registry + ":$BUILD_NUMBER"
		  
        }
      }
   }
stage("docker_scan"){
   steps{
        script {	  
        sh '''
         docker run -d --name db arminc/clair-db
         sleep 15
         docker run -p 6060:6060 --link db:postgres -d --name clair arminc/clair-local-scan
	 
         sleep 1
         DOCKER_GATEWAY=$(docker network inspect bridge --format "{{range .IPAM.Config}}{{.Gateway}}{{end}}")
	 
         wget -qO clair-scanner https://github.com/arminc/clair-scanner/releases/download/v8/clair-scanner_linux_amd64 && chmod +x clair-scanner
	 
         ./clair-scanner --ip="$DOCKER_GATEWAY" --threshold="High" rahulyerme1234/cicdpipelinetask:$BUILD_NUMBER || exit 0
       '''
    }
   }
  }	 
   stage('push docker image') {
      steps {
		script {
			withDockerRegistry(credentialsId: 'dockerhub') {
			  appImage.push("${env.BUILD_NUMBER}")
			  appImage.push("latest")
			}
		  }
        
      }
    }
    stage('build && SonarQube analysis') {
        steps {
                withSonarQubeEnv('My SonarQube Server') {
                    // Optionally use a Maven environment you've configured already
                    withMaven(maven:apache-maven-3.6) {
                        sh 'mvn clean package sonar:sonar'
                    }
                }
            }
        }  
  }
  post {
    success {
      office365ConnectorSend color: '#00cc00', message: "Success  ${JOB_NAME} build_number:${BUILD_NUMBER}, branch:${env.GIT_BRANCH} url:(<${BUILD_URL}>)", status: 'SUCCESS', webhookUrl: "${env.TEAMS_WEBHOOK}"
    }
    failure {
      office365ConnectorSend color: '#fc2c03', message: "Failed  ${JOB_NAME} build_number:${BUILD_NUMBER}, branch:${env.GIT_BRANCH} url:(<${BUILD_URL}>)", status: 'FAILED', webhookUrl:"${env.TEAMS_WEBHOOK}"
    }
  }
}
