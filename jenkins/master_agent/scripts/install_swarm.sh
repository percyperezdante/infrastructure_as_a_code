#!/bin/bash

# This is a very simple script to install swarm client and run it a service.
# Root access is required

HOME_JENKINS="/app/jenkins"

log(){
	TYPE=$1
  	MESSAGE=$2
	ACTION=$3
	echo " "`date +%Y%m%d" "%T`","$TYPE","$MESSAGE","$ACTION
}

create_user(){
   USER=$1
   useradd -d /app/$USER $USER
   #chown /app/$USER: $USER
   #chown /home/$USER: $USER
   id $USER
}

config_swarm_service(){
    SERVICE_PATH="/etc/systemd/system"
    if [ -d $SERVICE_PATH ];
    then
        cp /tmp/jenkins-agent.service $SERVICE_PATH/
        ls -ltr $SERVICE_PATH/jenkins-agent.service
    else
        log ERROR "$SERVICE_PATH does not exits to set service"
        exit 1
    fi
}

run_swarm_service(){
    service jenkins-agent force-reload
    systemctl enable jenkins-agent
    service jenkins-agent start
}

download_swarm_client(){
    SWARM_VERSION=3.9

    if [ ! -d $HOME_JENKINS ];
    then
        mkdir $HOME_JENKINS
    fi
    if [ ! -d $HOME_JENKINS/cli ];
    then
        mkdir $HOME_JENKINS/cli
    fi
    SWARM_CLIENT=$HOME_JENKINS/cli/swarm-client.jar
    curl -o $SWARM_CLIENT https://repo.jenkins-ci.org/releases/org/jenkins-ci/plugins/swarm-client/${SWARM_VERSION}/swarm-client-${SWARM_VERSION}.jar
    ls -ltr $SWARM_CLIENT
}

install_git(){
    # TODO Install the latest version from source code
    apt-get install -y git
}

create_ssh_dir(){
    if [ ! -d $HOME_JENKINS/.ssh ];
    then
        mkdir -m 700 $HOME_JENKINS/.ssh
    fi
    chown jenkins: $HOME_JENKINS/.ssh
}

# Add the coe-dev-jenkins key
# TODO: To automate how to copy keys to the new server,
#       For now this is manual, so it is placed as last step
add_rsa_key(){
    if [ -f $HOME_JENKINS/.ssh/id_rsa ];
    then
        ./add_jenkins_keys.sh
    else
        log ERROR "coe-dev-jenkins id_rsa is not present" "Copy it from rattic, then execute ./add_jenkins_keys.sh"
        exit 1
    fi
}

# This is copied because Jenkins can not login to the server for first time
copy_known_hosts(){
    cp ./known_hosts $HOME_JENKINS/.ssh/
    chown jenkins: $HOME_JENKINS/.ssh/known_hosts
}

##############################################################
log INFO "Start"
create_user jenkins
download_swarm_client
config_swarm_service
run_swarm_service
#install_git
#create_ssh_dir
#copy_known_hosts
#add_rsa_key
log INFO "End"


