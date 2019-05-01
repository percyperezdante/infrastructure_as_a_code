# Jenkins master agent infrastructure

# Objective
The code in this folder set ups a Jenkins master/agent infrastructure.


# How to run

## Prerequisites

You need to install docker and docker-compose in your host machine.

## Steps

1. To set up master-agent cluster:

```
$ cd master_agent

$ docker-compose up --build 
```
2. Open in the host machine.

```
localhost:10011
```
3. Set admin password by copyng the initial password from:

```bash
$ cat /var/jenkins_home/secrets/initialAdminPassword
```
   * You can copy the password from the output log or from below path
in the docker "jenkins_master" container.
   * If you find dificulties to find this secret, then use percy/123.

4. Do not install plugins.

   * All plugins are copied in to /var/jenkins_home/plugins. Therefore
you do not need to install them.  In the windows "Customize Jenkins"
select "Select plugins to install" -> Click on "none" -> click "install"

5. The  default port for UI is 10011, so  in the  windows "Instance configuration" 
click "save and finish". 

6. Finally, click on "Start using Jenkins"


# NOTE
1. If you want to just work on Jenkins master

```bash
$ docker-compose up --build jenkins_master

```
2. To create a docker network "jenkins_network"

```bash
$ docker network create jenkins_network
```

# Structure

1. ".scripts" : scripts that set up the containers.
2. ".confic": configuration files such as dockerfile.
3. ".shared": shared files and directories with hosted containers.

# Features

1. Jenkins master has a set of default plugins, plus the followings:
   - Self-Organizing Swarm Plug-in Modules
   - Build Pipeline Plugin

2. Accounts created by default:
   - admin/xxx, xxx is the default password that requires to be changed.
   - percy/123 




# TODO
- Configure master with swarm
- Add credentials to jenkins master

