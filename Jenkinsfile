pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'ishwarya2001/application'
        DOCKER_TAG = 'v1'
        FULL_IMAGE = 'ishwarya2001/application:v1'
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Test') {
            steps {
                echo '🔍 Running Go tests...'
                bat 'go test ./...'
            }
        }

        stage('Build Docker Image') {
            steps {
                echo '🐳 Building Docker image...'
                bat 'docker build -t %FULL_IMAGE% .'
            }
        }

        stage('Push to Docker Hub') {
            steps {
                echo '📦 Pushing Docker image...'
                withCredentials([usernamePassword(credentialsId: 'docker-credential', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    bat 'echo %DOCKER_PASS% | docker login -u %DOCKER_USER% --password-stdin'
                    bat 'docker push %FULL_IMAGE%'
                }
            }
        }
    }

    post {
        success {
            echo '✅ Pipeline completed successfully.'
        }
        failure {
            echo '❌ Pipeline failed.'
        }
    }
}
