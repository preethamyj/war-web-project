pipeline {
    agent any
       environment {
           PATH="/usr/bin/mvn/bin:$PATH"
       }
    stages {
        stage ('build') {
            steps {
               git credentialsId: 'gitclone', url: 'https://github.com/preethamyj/war-web-project.git'
            }
        }
        stage ('mvnbuild') {
            steps {
                sh 'mvn clean install'
            }
        }
         stage ('build dockerimage'){
            steps {
                sh 'chmod 777 /var/run/docker.sock' 
                sh 'docker build -t docker635067/test:preethu .'
                // sh 'docker tag war docker635067/test:hub'
            }
        }
        stage ('push docker image') {
            steps {
                sh 'cat ~/my_password.txt | docker login --username docker635067 --password-stdin'
                sh 'docker push docker635067/test:preethu'
            }
        }
        stage ('deploy image') {
            steps {
                sh "docker run -d -p 8085:8080 docker635067/test:preethu"
            }
        }
    } 
}
