pipeline {
    agent any
    stages {
        stage('Pull Image') {
            steps {
    
                sshagent(['docker-server']) {
                    sh 'ssh root@34.229.76.254 "docker pull nivethadhakshinamoorthy/static-website-nginx:latest"'
                }
            }
        }

        stage('Run Container') {
            steps {
                
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
                
                sh 'curl -I http://34.229.76.254:8082 || exit 1'
            }
        }
    }
}
