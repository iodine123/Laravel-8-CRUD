pipeline{
    agent any
    environment{
        DOCKERHUB_CREDENTIALS=credentials('dockerhub-credentials')
        GITHUB_PUSH=credentials('git-push')
    }
    stages{
        stage("Build Image"){
            steps{
                sh ''' 
                    rm -rf Laravel-8-CRUD
                    git clone https://github.com/iodine123/Laravel-8-CRUD
                    docker build -t iodinehanifan/laravel-app:1.${BUILD_NUMBER} .
                '''
            }
        }
    
        stage("Push Image"){
            steps{
                sh ''' 
                    echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin
                    docker push iodinehanifan/laravel-app:1.${BUILD_NUMBER}
                '''
            }
        }

        stage("Update Manifest"){
            steps{
                sh ''' 
                        git config --global user.name "iodine123"
                        git config --global user.email "iodinehanifan@gmail.com"
                    '''
                sh "sed -i 's/iodinehanifan/laravel-app.*/iodinehanifan/laravel-app:1.${BUILD_NUMBER}/g' deployment/app-deployment.yml"
                sh "cat deployment/app-tier.yml"  
                sh '''
                        git add deployment/app-tier.yml
                        git commit -m "Update manifest"
                        git remote set-url origin https://$GITHUB_PUSH_PSW@github.com/iodine123/Laravel-8-CRUD.git
                        git push https://$GITHUB_PUSH_USR:$GITHUB_PUSH_PSW@github.com/iodine123/Laravel-8-CRUD.git HEAD:master
                    '''         
            }
        }
    }
}