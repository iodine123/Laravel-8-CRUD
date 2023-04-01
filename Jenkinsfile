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

        stage("Update manifest for deployment"){
            steps{
                sh "sed -i 's/nginx.*/nginx:1.${BUILD_NUMBER}/g' deployment/app-tier.yml"
                sh "cat deployment/app-tier.yml"           
            }
        }

        stage("Push to Git"){
            steps{
                script{
                    sh '''
                        git config --global user.name "iodine123"
                        git config --global user.email "iodinehanifan@gmail.com"
                        git add deployment/app-tier.yml
                        git commit -m "Update manifest"
                    '''
                }
                withCredentials([usernamePassword(credentialsId: 'github-push', passwordVariable: 'pass', usernameVariable: 'user')]){
                    sh "git push http://$user:$pass@github.com/iodine123/Laravel-8-CRUD.git master"
                }
            }
        }
    }
}