pipeline {
    agent any
    stages {
        stage('Pull Image') {
            steps {
                // Pulls the latest image from Docker Hub on the remote server
                sshagent(['docker-server']) {
                    sh 'ssh root@34.229.76.254 "docker pull nivethadhakshinamoorthy/static-website-nginx:latest"'
                }
            }
        }

        stage('Run Container') {
            steps {
                // Stops and removes any existing container, then runs a new one on the remote server
                sshagent(['docker-server']) {
                    sh '''
                        ssh root@34.229.76.254 "docker stop main-container || true"
                        ssh root@34.229.76.254 "docker rm main-container || true"
                        ssh root@34.229.76.254 "docker run --name main-container -d -p 8082:80 nivethadhakshinamoorthy/static-website-nginx:latest"
                    '''
                }
            }
        }

        stage('Test Website') {
            steps {
                // Tests if the website is accessible on the new container on the remote server
                sh 'curl -I http://34.229.76.254:8082 || exit 1'
            }
        }
    }
}
