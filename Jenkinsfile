pipeline {
    agent any
    
    environment {
        dockerImage =''
        registry = 'encoretvm/myfirstapp'
        registryCredential = 'dockerhub_id'
    }
    
    stages {
        stage('Checkout') {
            steps {
                checkout([$class: 'GitSCM', branches: [[name: '*/master']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/encore-tvm/k8s-projects']]])
            }
        }
        
        stage('Build Docker Image') {
            steps {
                script {
                    dockerImage = docker.build registry
                }
            }
        }
        stage('Uploading Image') {
            steps {
                script {
                    docker.withRegistry('',registryCredential) {
                        dockerImage.push()    
                    }
                }
            }
        }
        
        // Stopping Docker containers for cleaner Docker run
        stage('docker stop container') {
            steps {
                sh 'docker ps -f name=myWebContainer -q | xargs --no-run-if-empty docker container stop'
                sh 'docker container ls -a -fname=myWebContainer -q | xargs -r docker container rm'
            }
        }
    }
}
