pipeline {
    agent any

    tools {
        maven 'maven-3.9.12'
    }

    environment {
        APP_NAME = "sbom-demo-app"
        SBOM_DIR = "sbom"
    }

    stages {

        stage('Checkout') {
            steps {
                echo 'Checking out code...'
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
                echo 'Generating SBOM using Syft...'
                bat '''
                if not exist %SBOM_DIR% mkdir %SBOM_DIR%
                syft dir:. -o cyclonedx-json=%SBOM_DIR%\\sbom.json
                '''
            }
        }

        stage('Archive SBOM') {
            steps {
                echo 'Archiving SBOM...'
                archiveArtifacts artifacts: 'sbom/sbom.json', fingerprint: true
            }
        }
    }

    post {
        success {
            echo '✅ Build and SBOM generation completed successfully!'
        }
        failure {
            echo '❌ Pipeline failed. Check logs above.'
        }
        always {
            echo 'Pipeline finished!'
        }
    }
}
