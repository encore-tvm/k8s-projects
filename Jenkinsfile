pipeline {
    agent any

    stages{
        stage('Deploy to Docker'){
            steps{
                sshagent(['centos-docker']) {
                     sh "ssh centos@192.168.10.37 docker run -d -p 8081:8081 --name nodeapp nginx"
                }
            }
        }
    }
}
