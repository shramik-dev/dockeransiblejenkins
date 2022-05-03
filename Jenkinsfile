pipeline{
    agent any
    tools {
      maven 'mvn'
    }
    environment {
      DOCKER_TAG = getVersion()
    }
    stages{
        stage('SCM'){
            steps{
                git branch: 'shramik-dev-patch-1', url: 'https://github.com/shramik-dev/dockeransiblejenkins.git'
            }
        }
        stage('Maven Build'){
            steps{
                sh "mvn clean package"
            }
        }
        stage('Docker Build'){
            steps{
                sh "docker build . -t shramik999/webapp:${DOCKER_TAG} "
            }
        }
        stage('DockerHub Push'){
            steps{
                withCredentials([string(credentialsId: 'docker-hub', variable: 'dockerHubPwd')]) {
                    sh "docker login -u shramik999 -p ${dockerHubPwd}"
                }
                
                sh "docker push shramik999/webapp:${DOCKER_TAG} "
            }
        }
        stage('Docker Deploy'){
            steps{
        ansiblePlaybook credentialsId: 'dev-server', disableHostKeyChecking: true, extras: "-e DOCKER_TAG=${DOCKER_TAG}", installation: 'ansible', inventory: 'dev.inv', playbook: 'deploy-docker.yml'
             
            }      
        }
    }
}
def getVersion(){
    def commitHash = sh label: '', returnStdout: true, script: 'git rev-parse --short HEAD'
    return commitHash
    }
