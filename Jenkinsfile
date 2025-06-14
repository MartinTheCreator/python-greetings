pipeline {
  agent any

  /*
   * If the env path is not configured in Jenkins define it
   * within the environment structure
   *
    environment {
      PATH = "/usr/local/bin:/usr/bin:/bin:${env.PATH}"
    }
  */

  stages {
    stage('build') {
      steps {
        script {
          buildImage()
        }
      }
    }
    stage('deploy-to-dev') {
      steps {
        script {
          deployTo('DEV')
        }
      }
    }
    stage('tests-on-dev') {
      steps {
        script {
          testOn('DEV')
        }
      }
    }
    stage('deploy-to-stg') {
      steps {
        script {
          deployTo('STG')
        }
      }
    }
    stage('tests-on-stg') {
      steps {
        script {
          testOn('STG')
        }
      }
    }
    stage('deploy-to-prod') {
      steps {
        script {
          deployTo('PROD')
        }
      }
    }
    stage('tests-on-prod') {
      steps {
        script {
          testOn('PROD')
        }
      }
    }
  }
}

def pullImage(image) {
  sh "docker pull ${image}"
}

def buildImage() {
  echo "Building an image of Python microservice has started..."
  sh "docker build -t mmatovski/python-greetings-app:latest ."
  sh "docker push mmatovski/python-greetings-app:latest"
}

def deployTo(environment) {
  echo "Deploying Python microservice to ${environment} environment..."
  pullImage("mmatovski/python-greetings-app:latest")
  sh "docker compose stop greetings-app-${environment.toLowerCase()}"
  sh "docker compose rm -f greetings-app-${environment.toLowerCase()}"
  sh "docker compose up -d greetings-app-${environment.toLowerCase()}"
}

def testOn(environment) {
  echo "Testing Python microservice on ${environment} environment..."
  pullImage("mmatovski/api-tests:latest")

  sh "docker run --rm -i --network=host mmatovski/api-tests:latest run greetings greetings_${environment.toLowerCase()}"
}
