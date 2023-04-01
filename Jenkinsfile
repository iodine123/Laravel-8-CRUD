pipeline{
    agent any
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
                    docker push iodinehanifan/laravel-app
                '''
            }
        }
    }
}