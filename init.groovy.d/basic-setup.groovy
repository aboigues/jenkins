import jenkins.model.*

def instance = Jenkins.getInstance()
instance.setInstallState(InstallState.INITIAL_SETUP_COMPLETED)

def hudsonRealm = new hudson.security.HudsonPrivateSecurityRealm(false)
hudsonRealm.createAccount(System.getenv('JENKINS_USER'), System.getenv('JENKINS_PASS'))
instance.setSecurityRealm(hudsonRealm)

def strategy = new hudson.security.FullControlOnceLoggedInAuthorizationStrategy()
instance.setAuthorizationStrategy(strategy)
instance.save()


