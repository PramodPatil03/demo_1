pipeline {
    agent any

    tools {
        maven 'Maven3'
        jdk 'JDK17'
    }

    environment {
        DOCKER_IMAGE = "pramod1906/demo_1"
        // DOCKER_TAG = "${BUILD_NUMBER}"
        DOCKER_TAG = 1.0
        KUBECONFIG = 'C:\\Users\\Pramo\\.kube\\config'
    }

    stages {

        stage('Checkout') {
            steps {
                git branch: 'develop',
                url: 'https://github.com/PramodPatil03/demo_1.git'
            }
        }

        stage('Build') {
            steps {
                bat 'mvn clean compile'
            }
        }
        

        stage('Test') {
            steps {
//                 bat 'mvn test'
                  echo 'Skipping tests'
            }
        }

        stage('Package') {
            steps {
                bat 'mvn clean package -DskipTests'
            }
        }

        stage('Build Docker Image') {
            steps {
                bat 'docker build -t %DOCKER_IMAGE%:%DOCKER_TAG% .'
            }
        }

        stage('Push Docker Image') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'dockerCreds',
                    usernameVariable: 'DOCKER_USER',
                    passwordVariable: 'DOCKER_PASS'
                )]) {

                    bat '''
                    docker login -u %DOCKER_USER% -p %DOCKER_PASS%

                    docker push %DOCKER_IMAGE%:%DOCKER_TAG%
                    '''
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {

                powershell '''
                (Get-Content deployment.yaml) `
                    -replace 'pramod1906/demo_1:latest', "pramod1906/demo_1:$env:DOCKER_TAG" |
                    Set-Content deployment.yaml

                kubectl apply -f deployment.yaml
                kubectl apply -f service.yaml
                ''' 
            }
        }
    }

    post {
        success {
            echo 'Deployment successful!'
        }

        failure {
            echo 'Pipeline failed!'
        }
    }
}
