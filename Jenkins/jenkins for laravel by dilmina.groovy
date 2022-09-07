pipeline {
     agent any
     stages {
        stage("Build") {
            steps {
                slackSend channel: 'jenkins-alerts', message: 'BUILD START: Job EDUCAST-API'
                //pls do not do any changes
                sh "composer install"
                sh "sudo chmod -R 777 ${WORKSPACE}"
                sh "sudo mv ${WORKSPACE}/.env.prod ${WORKSPACE}/.env"
                sh "php artisan optimize"
                //check jenkins 1.0
            }
        }
        stage("Deploy") {
            steps {
                sh "sudo chmod -R 777 ${WORKSPACE}"
                sh "sudo chmod -R 777 /var/www/educast/educast-api"
                sh "sudo chmod -R 777 /var/www/educast"
                sh "sudo rm -rf /var/www/educast/educast-api"
                sh "sudo mkdir -p /var/www/educast/educast-api"
                sh "sudo cp -r ${WORKSPACE}/. /var/www/educast/educast-api"
                sh "sudo chown -R ubuntu:ubuntu /var/www/educast/educast-api" 
                sh "sudo systemctl reload nginx"
            }
        }
    }
    post {
        success {
          slackSend channel: 'jenkins-alerts', color: '#00FF00', message: 'SUCCESSFUL: Job EDUCAST-API'
        }

        failure {
          slackSend channel: 'jenkins-alerts', color: '#FF0000', message: 'FAILED: Job EDUCAST-API'
        }
    }
}