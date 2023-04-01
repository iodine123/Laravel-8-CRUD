pipeline{
    agent any
    environment{
        DOCERHUB_CREDENTIALS=credentials('dockerhub-credentials')
    }
    stages{
        stage("Build Image"){
            steps{
                sh ''' 
                    git clone https://github.com/iodine123/Laravel-8-CRUD
                    echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin
                    docker build -t iodinehanifan/laravel-app
                '''
            }
        }
    
        stage("Push Image"){
            steps{
                sh ''' 
                    docker push iodinehanifan/laravel-app
                '''
            }
        }
    }
}