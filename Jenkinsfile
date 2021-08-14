pipeline {
    agent any

    stages{
        stage('Deploy to Docker'){
            steps{
                sshagent(['centos-docker']) {
                     sh "scp -o StrictHostKeyChecking=no Jenkinsfile centos@192.168.10.37:/tmp"
                }
            }
        }
    }
}
