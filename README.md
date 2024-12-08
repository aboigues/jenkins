# Jenkins dans docker
## Utiliser Jenkins pour analyzer les images et signaler les images avec des failles trop critiques

## 1. Constuire l'image personalisée avec les derniers plugins

```
docker compose build
```

## 2. Délpoyer Jenkins
```
docker compose up -d
```

## 3. Accéder à Jenkins
```
http://localhost:8080
```
Login: admin
pwd: admin

## 4. Enregistrer ses credentials du dockerhub dans Jenkins

Aller dans Tableau de Bord > Administrer Jenkins > Credentials > domain (global) > Add credential > Portée par defaut
  > Votre Nom utilisateur Docker HUB + Votre Mot de passe Docker HUB + ID : jenkins-docker-hub-credentials

## 5. Créer un job 

Aller dans Nouvel Item > nom + pipeline
Choisir Pipeline Script:
```
pipeline {
    agent any

    environment {
        DOCKER_HUB = credentials('jenkins-docker-hub-credentials')
        IMAGE_TAG  = 'VOTRE-COMPTE/VOTRE-IMAGE:latest'
    }

    stages {
        stage('Analyze image') {
            steps {
                // Install Docker Scout
                sh 'curl -sSfL https://raw.githubusercontent.com/docker/scout-cli/main/install.sh | sh -s -- -b /usr/local/bin'

                // Log into Docker Hub
                sh 'echo $DOCKER_HUB_PSW | docker login -u $DOCKER_HUB_USR --password-stdin'

                // Analyze and fail on critical or high vulnerabilities
                sh 'docker-scout cves $IMAGE_TAG --exit-code --only-severity critical,high'
            }
        }
    }
}
```

## 6. lancer le job depuis le tableau de bord
