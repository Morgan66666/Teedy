pipeline {
    agent any
    stages {
        stage('Build') { 
            steps {
                sh 'mvn -B -DskipTests clean package' 
            }
        }
        stage('pmd') {
            steps {
                sh 'mvn pmd:pmd'
            }
        }

        stage('Test') {
            steps {
                // 运行测试并生成 surefire 报告
                sh 'mvn test surefire-report:report'
            }
            post {
                always {
                    // 存档 surefire 报告
                    archiveArtifacts artifacts: '**/surefire-reports/*.xml', fingerprint: true
                    junit '**/surefire-reports/*.xml'
                }
            }
        }

        stage('Generate Javadoc') {
            steps {
                // 生成 Javadoc jar
                sh 'mvn javadoc:jar -Dmaven.javadoc.failOnError=false'
'
            }
            post {
                always {
                    // 存档生成的 Javadoc jar
                    archiveArtifacts artifacts: '**/target/*-javadoc.jar', fingerprint: true
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
