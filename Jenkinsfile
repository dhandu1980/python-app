pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'your-repo/python-app'
        ARTIFACTORY_URL = 'https://your-artifactory-instance/artifactory'
        ARTIFACTORY_CRED = credentials('jfrog-credentials-id')
        EKS_CLUSTER = 'your-eks-cluster'
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'master', url: 'https://github.com/your-username/your-repo.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    docker.build(DOCKER_IMAGE)
                }
            }
        }

        stage('Push Docker Image to JFrog') {
            steps {
                script {
                    docker.withRegistry("${env.ARTIFACTORY_URL}", "${env.ARTIFACTORY_CRED}") {
                        docker.image("${DOCKER_IMAGE}").push("latest")
                    }
                }
            }
        }

        stage('Deploy to EKS') {
            steps {
                script {
                    sh """
                    aws eks --region your-region update-kubeconfig --name ${env.EKS_CLUSTER}
                    kubectl apply -f k8s/deployment.yaml
                    kubectl apply -f k8s/service.yaml
                    """
                }
            }
        }
    }

    post {
        always {
            cleanWs()
        }
    }
}