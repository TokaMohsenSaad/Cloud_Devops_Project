@Library('github-jenkins-global-lib') _

pipeline {
    agent any
    
    environment {
        IMAGE_NAME = 'grad-pro'
        REGISTRY = 'tokamohsen2001'
        TAG = "${BUILD_NUMBER}"
        GIT_REPO_URL = 'github.com/TokaMohsenSaad/Cloud_Devops_Project.git'
        GIT_CREDENTIALS = 'git_credentials'
        DOCKER_PATH = 'docker'
        MANIFEST_PATH = 'kubernetes/deployment.yml'
    }
    
    stages {
        stage('Build Image') {
            steps {
                buildImage(env.IMAGE_NAME, env.TAG)
            }
        }
        
        stage('Scan Image') {
            steps {
                scanImage(env.IMAGE_NAME, env.TAG)
            }
        }
        
        stage('Push Image') {
            steps {
                script {
                    // Login to Docker Hub
                    withCredentials([usernamePassword(credentialsId: 'dockerhub-credentials', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                        sh "echo ${DOCKER_PASS} | docker login -u ${DOCKER_USER} --password-stdin"
                    }
                    pushImage(env.IMAGE_NAME, env.TAG, env.REGISTRY)
                }
            }
        }
        
        stage('Delete Image Locally') {
            steps {
                deleteLocalImage(env.IMAGE_NAME, env.TAG, env.REGISTRY)
            }
        }
        
        stage('Update Manifests') {
            steps {
                updateManifests(env.IMAGE_NAME, env.TAG, env.REGISTRY, env.MANIFEST_PATH)
            }
        }
        
        stage('Push Manifests') {
            steps {
                pushManifests(env.GIT_CREDENTIALS, env.GIT_REPO_URL)
            }
        }
    }
    
    post {
        always {
            cleanWs()
        }
        failure {
            echo "Pipeline failed! Check logs for details."
        }
        success {
            echo "Pipeline completed successfully!"
        }
    }
}