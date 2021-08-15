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
        
        stage("Docker Build 1"){
            steps {
                sh 'docker version'
                sh 'docker build -t my-node-app:1 .'
                sh 'docker images'
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
                // sh 'docker ps -f name=myWebContainer -q | xargs --no-run-if-empty docker container stop'
                sh 'docker container ls -a -fname=myWebContainer -q | xargs -r docker container rm -f'
            }
        }
        // Running Docker container, make sure port 8090 is opened in 
        stage('Docker Run') {
            steps {
                script {
                    dockerImage.run("-p 8090:3000 --rm --name myWebContainer")
                }
            }
        }
        // SSH Into k8smaster server
        stage("SSH Into k8s Server") {
            steps { 
                script {
                    //def remote = [:]
                   // remote.name = 'K8S master'
                    //remote.host = '192.168.20.11'
                    //remote.user = 'vagrant'
                   // remote.password = 'vagrant'
                    //remote.allowAnyHosts = true
                    
                    sshagent(['k8s-master']) {
                        sh "SSH_AUTH_SOCK=${env.SSH_AUTH_SOCK} ssh-add -l"
                        sh "scp -o StrictHostKeyChecking=no Deployments.yaml vagrant@192.168.20.11:/tmp"
                    }
                }
            }
        } 
    }
}
