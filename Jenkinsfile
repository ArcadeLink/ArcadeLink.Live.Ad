pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                // Check out from version control
                checkout scm
            }
        }

        stage('Build') {
            steps {
                // Build the project for Linux
                sh 'flutter build linux'
            }
        }

        stage('Archive') {
            steps {
                // Archive the build output
                sh 'tar -czvf build.tar.gz build/linux'
                archiveArtifacts artifacts: 'build.tar.gz', fingerprint: true
            }
        }
    }
}