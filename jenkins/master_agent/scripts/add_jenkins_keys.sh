#!/bin/bash

# This script adds the .ssh/id_rsa  to an agent
# in order to be recognised by COE gitlab
# Once the process to copy rsa keys are automated
# this script should be integrated to install.sh
#

RSA_JENKINS="/app/jenkins/.ssh/id_rsa"
if [ -f $RSA_JENKINS ];
then
    chown jenkins: $RSA_JENKINS
    chmod 700 $RSA_JENKINS
    eval `ssh-agent -s`
    ssh-add $RSA_JENKINS
else
    echo "ERROR coe-dev-jenkins id_rsa is not present. Copy it from rattic, then execute add_jenkins_keys.sh"
    exit 1
fi



