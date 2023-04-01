pipeline{
    agent any
    environment{
        DOCKERHUB_CREDENTIALS=credentials('dockerhub-credentials')
        GITHUB_PUSH=credentials('git-push')
        APP_NAME="laravel-app"
        IMAGE_NAME="${DOCKERHUB_CREDENTIALS_USR}" + "/" + "${APP_NAME}" + ":1"
    }
    stages{
        stage("Build Image"){
            steps{
                sh ''' 
                    rm -rf Laravel-8-CRUD
                    git clone https://github.com/iodine123/Laravel-8-CRUD
                    docker build -t ${IMAGE_NAME}.${BUILD_NUMBER} .
                '''
            }
        }
    
        stage("Push Image"){
            steps{
                sh ''' 
                    echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin
                    docker push ${IMAGE_NAME}.${BUILD_NUMBER}
                '''
            }
        }

        stage("Update Manifest"){
            steps{
                sh ''' 
                        git config --global user.name "iodine123"
                        git config --global user.email "iodinehanifan@gmail.com"
                    '''
                sh """ sed -i "s/${APP_NAME}.*/${APP_NAME}:1.${BUILD_NUMBER}/g" deployment/app-deployment.yml"""
                sh "cat deployment/app-deployment.yml"  
                sh '''
                        git add deployment/app-deployment.yml
                        git commit -m "Update manifest"
                        git remote set-url origin https://$GITHUB_PUSH_PSW@github.com/iodine123/Laravel-8-CRUD.git
                        git push https://$GITHUB_PUSH_USR:$GITHUB_PUSH_PSW@github.com/iodine123/Laravel-8-CRUD.git HEAD:master
                    '''         
            }
        }
    }
}