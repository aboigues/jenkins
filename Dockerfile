FROM jenkins/jenkins:2.479.2-lts-jdk17

USER root

# Installer Docker CLI
RUN apt-get update && \
    apt-get install -y docker.io && \
    rm -rf /var/lib/apt/lists/*

# Ajouter des plugins Jenkins essentiels
RUN jenkins-plugin-cli --plugins "pipeline-model-definition docker-workflow"
RUN jenkins-plugin-cli --plugins credentials:1389.vd7a_b_f5fa_50a_2
RUN jenkins-plugin-cli --plugins workflow-job:1472.ve4d5eca_143c4
RUN jenkins-plugin-cli --plugins scm-api:698.v8e3b_c788f0a_6


# Copier les scripts d'initialisation
COPY init.groovy.d/* /var/jenkins_home/init.groovy.d/

USER jenkins


