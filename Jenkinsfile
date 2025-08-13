pipeline {
  agent any
  options { skipDefaultCheckout(true) }
  stages {
    stage('Checkout') {
      steps { checkout scm }
    }
    stage('Build') {
      steps { echo 'Hello from Jenkins via ngrok!' }
    }
    stage('Test') {
      steps { sh 'echo running tests...' }
    }
  }
}
