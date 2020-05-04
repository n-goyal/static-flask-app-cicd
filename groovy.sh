node{
    stage('Git Checkout') {
        git credentialsId: 'git-creds', url: 'https://github.com/n-goyal/static-flask-app-cicd'
    }
    stage('Docker build') {
        sh 'docker build -t nitingo/static-flask:v1.0 .'
    }
    stage('Push image to hub'){
        withCredentials([string(credentialsId: 'docker-hub-creds', variable: 'dockerCreds')]) {
            sh "docker login -u nitingo -p ${dockerCreds}"
        }
        sh "docker push nitingo/static-flask:v1.0"
    }
    stage('pull image and Run Container'){
        sh 'docker pull nitingo/static-flask:v1.0'
        sh 'docker run -d -p 5000:5000 --name static-flask nitingo/static-flask:v1.0'
        sh 'sleep 30'
    }
    stage('Stop and Remove the Container'){
        sh 'docker stop static-flask'
        sh 'docker rm static-flask'
    }
}
