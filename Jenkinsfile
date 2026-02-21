pipeline {
    
    agent any 
    
    environment {
        IMAGE_TAG = "${BUILD_NUMBER}"
    }
    
    stages {
        
        stage('Checkout'){
           steps {
                git credentialsId: '74d5e1dd-5e1a-43a5-88ae-4bfb72250565', 
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
                git credentialsId: '74d5e1dd-5e1a-43a5-88ae-4bfb72250565', 
                url: 'git@github.com:iam-animasaun/cicd-todo.git',
                branch: 'main'
            }
        }
        
        stage('Update K8S manifest & push to Repo'){
            steps {
                script{
                    withCredentials([usernamePassword(credentialsId: '74d5e1dd-5e1a-43a5-88ae-4bfb72250565', passwordVariable: 'GIT_PASSWORD', usernameVariable: 'GIT_USERNAME')]) {
                        sh '''
			cd deploy
                        cat deploy.yaml
                        sed -i 's/32/${BUILD_NUMBER}/g' deploy.yaml
                        cat deploy.yaml
                        git add deploy.yaml
                        git commit -m 'Updated the deploy yaml | Jenkins Pipeline'
                        git remote -v
                        git push orgin HEAD:main
                        '''                        
                    }
                }
            }
        }
    }
}
