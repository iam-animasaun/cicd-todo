pipeline {
    
    agent any 
    
    environment {
        IMAGE_TAG = "${BUILD_NUMBER}"
    }
    
    stages {
        
        stage('Checkout'){
           steps {
                git credentialsId: 'github_ssh_key', 
                url: 'git@github.com:iam-animasaun/cicd-todo.git',
                branch: 'main'
           }
        }

        stage('Build Docker'){
            steps{
                script{
                    sh '''
                    echo 'Buid Docker Image'
                    docker build -t olatomiwa17/cicd-todo:${BUILD_NUMBER} .
                    '''
                }
            }
        }

        stage('Push the artifacts'){
           steps{
                script{
                    sh '''
                    echo 'Push to Repo'
                    docker push olatomiwa17/cicd-todo:${BUILD_NUMBER}
                    '''
                }
            }
        }
        
        stage('Checkout K8S manifest SCM'){
            steps {
                git credentialsId: 'github_ssh_key', 
                url: 'git@github.com:iam-animasaun/cicd-todo.git',
                branch: 'main'
            }
        }
        
        stage('Update K8S manifest & push to Repo'){
            steps {
                script{
                    sshagent(['github_ssh_key']) {
                        sh '''
			cd deploy
                        cat deploy.yaml
                        sed -i "s|image: olatomiwa17/cicd-todo:.*|image: olatomiwa17/cicd-todo:${BUILD_NUMBER}|g" deploy.yaml
                        sed -i "s|image: olatomiwa17/cicd-todo:.*|image: olatomiwa17/cicd-todo:${BUILD_NUMBER}|g" pod.yaml
                        cat deploy.yaml
                        git add .
                        git commit -m 'Updated the deploy yaml | Jenkins Pipeline'
                        git remote -v
                        git push origin HEAD:main
                        '''                        
                    }
                }
            }
        }
    }
}
