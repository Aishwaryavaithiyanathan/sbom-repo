pipeline {
    agent any

    environment {
        MAVEN_HOME = "C:\\Program Files\\Apache\\apache-maven-3.9.12"
        PATH = "${env.MAVEN_HOME}\\bin;${env.PATH}"
    }

    stages {
        stage('Checkout') {
            steps {
                echo 'Checking out code...'
                // Assuming local repo for now
                checkout scm
            }
        }

        stage('Build') {
            steps {
                echo 'Building Java app with Maven...'
                bat 'mvn clean package'
            }
        }

        stage('Generate SBOM') {
            steps {
                echo 'Generating SBOM with Syft...'
                // Point to jar target folder
                bat 'syft target/simple-app-1.0-SNAPSHOT.jar -o json > sbom.json'
            }
        }

        stage('Archive SBOM') {
            steps {
                archiveArtifacts artifacts: 'sbom.json', fingerprint: true
            }
        }
    }

    post {
        always {
            echo 'Pipeline finished!'
        }
    }
}
