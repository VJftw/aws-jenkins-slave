node {

    checkout scm

    stage('Pre-install') {
        sh 'scripts/pre_install.sh'
    }

    stage('Update Distribution') {
        sh 'scripts/dist_update.sh'
    }

    stage ('Installing/Upgrading') {
        sh 'scripts/install_all.sh'
    }

    stage ('Creating Jenkins Workspace') {
        sh 'scripts/create_jenkins_ws.sh'
    }

    stage ('Cleaning Up') {
        sh 'scripts/clean_up.sh'
    }

    stage ('Creating AMI') {
        withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', accessKeyVariable: 'AWS_ACCESS_KEY_ID', credentialsId: 'AWSJenkinsCredentials', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']]) {
            sh 'invoke create_ami'
        }
    }
}
