#!/bin/bash

### VARIABLE ###
# Pour la fonction update_helm
VERSION_HELM = $(helm version | cut -d '"' -f2 | cut -d "v" -f2)
# Pour la fonction scale_down
VERSION_CBOX = $(kubectl describe pod -n cryptobox | grep version | head -n 1 | cut -d"=" -f2)
NAMESPACE = "cryptobox"
# Pour la fonction upadate_CBOX
VERSION_CBOX_SPECIFIQUE = ""

### FONCTION ###
function gestion_erreur () {
    if [ "$?" -eq "0" ]; then printf "$1    \U2705\n\n"; else printf '\u2620 Failed \U2757\U2757\U2757\n'; exit 1; fi
}

function update_helm () {
    TEST_VERSION_HELM=$(printf "$VERSION_HELM\n3.5.0" | sort -V | head -n 1)
    printf "\U231B check de la version 'HELM' ... \n"
    if [ "$TEST_VERSION_HELM" -ne "3.5.0" ]; then printf "\U231B mise à jour de votre helm ... \n"; helm repo update &> /dev/null ; fi
    gestion_erreur "mise à jour de HELM réussi"
}

function scale_down () {
    if [ "$VERSION_CBOX" -lt "4.22" ]
        then
            kubectl scale deployment css css-periodic-tasks admin chap csws ctm fluentd --replicas=0 -n $NAMESPACE
            kubectl scale statefulset $NAMESPACE-redis-master --replicas=0 -n $NAMESPACE 
        else
            kubectl scale deployment css css-periodic-tasks admin chap csws ctm --replicas=0 -n $NAMESPACE
            kubectl scale statefulset $NAMESPACE-redis-master $NAMESPACE-fluentd --replicas=0 -n $NAMESPACE
    fi
    gestion_erreur "scale down réussi"
}

function update_CBOX () {
    printf "\U231B Debut de la mise à jour ... \n"
    if [[ ! -z "$var" ]]; 
        then
            helm upgrade -f myvalues.yml cryptobox --namespace $NAMESPACE cryptobox/cryptobox --version $VERSION_CBOX_SPECIFIQUE;
        else
            helm upgrade -f myvalues.yml cryptobox --namespace $NAMESPACE cryptobox/cryptobox; 
    fi
    gestion_erreur "Mise à jour términé."
}

function scale_up () {
    printf "\U231B scale-up des services ... \n"
    kubectl scale deployment css css-periodic-tasks admin chap csws ctm --replicas=0 -n $NAMESPACE
    kubectl scale statefulset $NAMESPACE-redis-master $NAMESPACE-fluentd --replicas=0 -n $NAMESPACE
    gestion_erreur "scale-up réussi"
}

function main () {
    update_helm
    scale_down
    update_CBOX
    scale_up
}

### MAIN ###
main
