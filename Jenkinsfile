hpipeline {
    agent any

    stages{
        stage('Deploy to Docker'){
            steps{
                sshagent(['centos-docker']) {
                    sh "ssh centos@192.168.10.37 echo"
                }
            }
        }
    }
}
