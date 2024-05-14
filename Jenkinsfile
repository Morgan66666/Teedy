pipeline {
  agent any
  stages {
    stage('Build') {
      steps {
        sh 'mvn -B -DskipTests clean package'
      }
    }
    stage('Deploy') {
      steps {
        sh 'kubectl set image deployments/teedy teedy=morgan666/teedy:8'
      }
    }
  }
}
