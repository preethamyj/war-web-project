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
        stage ('deploy to K8S') {
            steps {
	           sshagent(['ubuntu-kube']) {
                      sh "scp -o StrictHostKeyChecking=no pod.yml service.yml ubuntu@3.7.69.141:/home/ubuntu/pipeline"
			   script {
			    try {
			       sh "ssh ubuntu@3.7.69.141 sudo kubectl apply -f ./pipeline"
			        }
			    catch(error) {
				sh "ssh ubuntu@3.7.69.141 sudo kubectl create -f ./pipeline"    
                                   }
                              }
                    } 
		    
            } 
        }
    }
}
