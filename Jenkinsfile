pipeline {
    agent any
        stage('Docker Deploy Dev'){
            steps{
                sshagent(['tomcat-dev']) {
                    sh "ssh ec2-user@172.31.0.38 docker run -d -p 8080:8080 --name nodeapp ${IMAGE_URL_WITH_TAG}"
                }
            }
        }
}
