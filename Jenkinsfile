node {
    stage 'Build'
    checkout scm
    withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', accessKeyVariable: 'AWS_ACCESS_KEY_ID', credentialsId: 'AWSJenkinsCredentials', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']]) {
        wrap([$class: 'AnsiColorBuildWrapper', 'colorMapName': 'XTerm', 'defaultFg': 1, 'defaultBg': 2]) {
          sh '''
            set +x
            ./build.sh
          '''
        }
    }
}
