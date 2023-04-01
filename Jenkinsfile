pipeline{
    agent any
    environment{
        DOCKERHUB_CREDENTIALS=credentials('dockerhub-credentials')
    }
    stages{
        stage("Build Image"){
            steps{
                sh ''' 
                    rm -rf Laravel-8-CRUD
                    git clone https://github.com/iodine123/Laravel-8-CRUD
                    docker build -t iodinehanifan/laravel-app .
                '''
            }
        }
    
        stage("Push Image"){
            steps{
                sh ''' 
                    echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin
                    docker push iodinehanifan/laravel-app
                '''
            }
        }

        stage("Deploy"){
            steps{
                sh ''' 
                    cd deployment
                '''
            }
        }
    }
}