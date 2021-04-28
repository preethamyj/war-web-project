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
        stage ('deploy to k8s') {
            steps {
	           sshagent(['ubuntu-kube']) {
                      sh "ssh -o StrictHostKeyChecking=no ubuntu@172.31.15.32 sudo kubectl apply -f pod.yml || service.yml"                      
                       } 
           }
        }
    } 
}
