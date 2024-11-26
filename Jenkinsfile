pipeline {
    agent any
    stages {
        stage('Cleanup') {
            steps {
                cleanWs() // Cleans the workspace
            }
        }

        stage('Checkout Code') {
            steps {
                checkout scm // Checks out the code from the repository
            }
        }

        stage('Build Image') {
            steps {
                // Builds the Docker image
                sh '''
		sudo su
		docker build -t static-website-nginx:develop-${BUILD_ID} .
		'''
            }
        }

        stage('Run Container') {
            steps {
                // Stops and removes existing container, then runs a new one
                sh ''' sudo su 
		docker stop develop-container || true && sudo docker rm develop-container || true'''
                sh 'sudo su docker run --name develop-container -d -p 8081:80 static-website-nginx:develop-${BUILD_ID}'
            }
        }

        stage('Test Website') {
            steps {
                // Tests if the website is accessible
                sh 'curl -I http://3.84.218.176:8081'
            }
        }

        stage('Push Image') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-auth', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
                    sh '''
                        sudo su docker login -u $USERNAME -p $PASSWORD
                        sudo su docker tag static-website-nginx:develop-${BUILD_ID} $USERNAME/static-website-nginx:latest
                        sudo su docker tag static-website-nginx:develop-${BUILD_ID} $USERNAME/static-website-nginx:develop-${BUILD_ID}
                        sudo su docker push $USERNAME/static-website-nginx:latest
                        sudo su docker push $USERNAME/static-website-nginx:develop-${BUILD_ID}
                    '''
                }
            }
        }
    }
}

