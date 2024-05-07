pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                sh 'mvn -B -DskipTests clean package'
            }
        }
        stage('Docker Build') {
            steps {
                script {
                    sh 'docker build -t morgan666/teedy:${BUILD_ID} .'
                }
            }
        }
        stage('Docker Push') {
            steps {
                script {
                    sh 'docker push morgan666/teedy:${BUILD_ID}'
                }
            }
        }
        stage('Deploy') {
            steps {
                script {
                    // 运行 Docker 容器
                    sh 'docker run -d -p 8082:8080 morgan666/teedy:${BUILD_ID}'
                    sh 'docker run -d -p 8083:8080 morgan666/teedy:${BUILD_ID}'
                    sh 'docker run -d -p 8084:8080 morgan666/teedy:${BUILD_ID}'
                }
            }
        }
    }

    post {
        always {
            archiveArtifacts artifacts: '**/target/site/**', fingerprint: true
            archiveArtifacts artifacts: '**/target/**/*.jar', fingerprint: true
            archiveArtifacts artifacts: '**/target/**/*.war', fingerprint: true
        }
    }
}
