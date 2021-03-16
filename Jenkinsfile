pipeline {
    agent any
    stages {
        stage('Build and run backend') {
            steps {
                script {
                    sh 'mkdir -p /srv/maciejbadziak/millionaire-show/'
                    sh 'docker-compose -f /srv/maciejbadziak/millionaire-show/docker-compose.yml down || true'
                    sh 'mvn clean package'
                    sh 'rsync ./target/millionaire-show-2.4.1.jar /srv/maciejbadziak/millionaire-show/millionaire-show.jar'
                    sh 'rsync ./Dockerfile /srv/maciejbadziak/millionaire-show/Dockerfile'
                    sh 'rsync ./docker-compose.yml /srv/maciejbadziak/millionaire-show/docker-compose.yml'
                    sh 'docker-compose -f /srv/maciejbadziak/millionaire-show/docker-compose.yml build'
                    sh 'docker-compose -f /srv/maciejbadziak/millionaire-show/docker-compose.yml up -d'
                }
            }
        }

        stage('Test services availability') {
            steps {
                script{
                    def status = sh(script: "curl --write-out %{http_code} --silent --output /dev/null https://millionaire.maciejbadziak.pl", returnStdout: true)
                    sh "echo Millionaire: ${status}"
                    if (status != '200') {
                        sh "exit 1"
                    }
                }
            }
        }
    }
}
