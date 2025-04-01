pipeline {
    agent any
    
    stages {
        stage('Checkout Code') {
            steps {
                script {
                    sh '''
                        echo "Before Git Checkout - Current Directory:"
                        pwd
                        ls -l

                        echo "Updating repository instead of cloning..."
                        git pull origin master || echo "First run, nothing to pull."

                        echo "After Git Checkout - Current Directory:"
                        pwd
                        ls -l
                    '''
                }
            }
        }

        stage('Compile in Java 17 Container') {
            steps {
                script {
                    sh '''
                        echo "Before Starting Docker - Current Directory:"
                        pwd
                        ls -l
                        echo "Running Maven inside Docker container using the correct host path"
                        docker run --rm --name Java17\
                        -v /var/lib/docker/volumes/jenkins_home/_data/workspace/MidtermPipeline:/workspace \
                        -w /workspace \
                        maven:3.8.6-eclipse-temurin-17 \
                        sh -c 'echo "Inside Docker - Current Directory:"; pwd; ls -l; mvn clean compile'
                        echo "After Docker Execution - Current Directory:"
                        pwd
                        ls -l
                    '''
                }
            }
        }
        stage('Unit Tests in Java 11 Container') {
    steps {
        script {
            sh '''
                docker run --rm --name Java11 \
                -v /var/lib/docker/volumes/jenkins_home/_data/workspace/MidtermPipeline:/workspace \
                -w /workspace \
                maven:3.8.6-eclipse-temurin-11 \
                sh -c 'mvn clean test jacoco:report'
            '''
        }
    }
}

        stage('SonarQube Scan Using Java 1.8') {
    steps {
        withSonarQubeEnv('SQ1') {
            sh """
                docker run --rm --name sonarscanner --network jenkinsCI \
                  -e SONAR_TOKEN=${SONAR_AUTH_TOKEN} \
                  -e SONAR_HOST_URL=${SONAR_HOST_URL} \
                  -v /var/lib/docker/volumes/jenkins_home/_data/workspace/MidtermPipeline:/workspace \
                  -w /workspace \
                  maven:3.8.6-eclipse-temurin-8 \
                  sh -c    ' mvn sonar:sonar \
                            -Dsonar.host.url=${SONAR_HOST_URL} \
                            -Dsonar.login=${SONAR_AUTH_TOKEN} \
                            -Dsonar.java.source=1.8 \
                            -Dsonar.java.target=1.8 \
                            -Dsonar.coverage.jacoco.xmlReportPaths=target/site/jacoco/jacoco.xml
                            -Dsonar.exclusions=**/MathController.java,**/MathLinuxApplication.java'
            """
        }
    }
}

        stage('Package in Java 17 and Build Docker Image') {
    steps {
        sh '''
            docker run --rm --name Java17DockerImage\
              -v /var/lib/docker/volumes/jenkins_home/_data/workspace/MidtermPipeline:/workspace \
              -w /workspace \
              maven:3.8.6-eclipse-temurin-17 \
              mvn clean package spring-boot:repackage
        '''
        sh 'docker build -t thomasgean/mathlinux:latest .'
    }
}

        stage('Push to Docker Hub') {
    steps {
        withCredentials([usernamePassword(credentialsId: 'JenkinsDockerHub', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
            sh '''
                echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
                docker push thomasgean/mathlinux:latest
            '''
        }
    }
}
        stage('Deploy to Kubernetes') {
    steps {
        sh '''
            kubectl apply -f k8s/deployment.yaml
            kubectl apply -f k8s/service.yaml
            kubectl apply -f k8s/ingress.yaml
        '''
    }
}

    }
}