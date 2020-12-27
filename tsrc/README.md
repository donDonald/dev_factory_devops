# Test
This test runs 3 VMs:
 - dns server
 - postgers + pgadmin
 - simple server powered by node.js

The whole setup is pretty much close to real production environment.\
For VM management I use Vagrant.\
For devops management I use ansible.



### 1. Launch VMs and make a snapshot
```
$ vagrant up
```
Make sense to take VM snapshots like this:
```
$ vagrant halt
$ vagrant snapshot save v0.initial
```
Start VMs again:
```
$ vagrant up
```



### 2. Setup ssh access
Ansible is used for devops - to manage all the hosts, to install packages and other stuff.\
Ansible uses ssh and therefore all hosts SHALL be sshed with no password.\
Have to create and deploy ssh keys now.



#### 2.1 Create and add ssh keys
```
$ ssh-keygen -t rsa -f ansible.ssh.stuff -C "someuser@somedoman.com"
$ ssh-add ./ansible.ssh.stuff
```
If password is requested - press ENTER



#### 2.2 Copy ssh keys to VMs
```
$ ssh-copy-id -i ansible.ssh.stuff.pub vagrant@h1
$ ssh-copy-id -i ansible.ssh.stuff.pub vagrant@h2
$ ssh-copy-id -i ansible.ssh.stuff.pub vagrant@h3
```
Use "vagrant" as password



#### 2.3 Ensure all VMs can be sshed into with no passwrd requets
```
$ ssh vagrant@h1
$ ssh vagrant@h2
$ ssh vagrant@h3
```



### 2.4. Make sense to take VM snapshots like this:
```
$ vagrant halt
$ vagrant snapshot save v1.ssh
```
Start VMs again:
```
$ vagrant up
```



### 3. Setup VMs by running ansible
```
$ cd ansible
$ ansible-playbook -i hosts -K main.yml
```
Ansible will ask "BECOME" password - use "vagrant"



### 4. Check app is working in swarm mode
```
$ curl localhost:3000
[fb72b1c8015e@root] Hallo Node.js Server, reqs:2
$ curl localhost:3000
[1b99f6085a38@root] Hallo Node.js Server, reqs:2
$ curl localhost:3000
[fb72b1c8015e@root] Hallo Node.js Server, reqs:3
$ curl localhost:3000
[1b99f6085a38@root] Hallo Node.js Server, reqs:3
$ curl localhost:3000
[fb72b1c8015e@root] Hallo Node.js Server, reqs:4
$ curl localhost:3000
[1b99f6085a38@root] Hallo Node.js Server, reqs:4
$ curl localhost:3000
[fb72b1c8015e@root] Hallo Node.js Server, reqs:5
$ curl localhost:3000
[1b99f6085a38@root] Hallo Node.js Server, reqs:5
```



### 5. Shutdown VMs
```
$ vagrant halt
```


### To create swarm manually 

https://docs.docker.com/engine/reference/commandline/swarm_init/
https://upcloud.com/community/tutorials/docker-swarm-orchestration/



h1:
```
docker swarm init --advertise-addr 192.168.200.10
Swarm initialized: current node (m98v86a7q93zi5rjun8i6p15b) is now a manager.

To add a worker to this swarm, run the following command:

    docker swarm join --token SWMTKN-1-0jjl24jwksshl7ny1wbc0ftrszxpy6bjuosy5naic2n30ke6sk-e308lic59tmoa50s3tfslhf6p 192.168.200.10:2377

To add a manager to this swarm, run 'docker swarm join-token manager' and follow the instructions.
```



h2:
```
$ docker swarm join --token SWMTKN-1-0jjl24jwksshl7ny1wbc0ftrszxpy6bjuosy5naic2n30ke6sk-e308lic59tmoa50s3tfslhf6p 192.168.200.10:2377
This node joined a swarm as a worker.
```



h1:
```
$ docker node ls
ID                            HOSTNAME   STATUS    AVAILABILITY   MANAGER STATUS   ENGINE VERSION
m98v86a7q93zi5rjun8i6p15b *   h1         Ready     Active         Leader           19.03.13
n0521us8vhnfvf18ii7edvfry     h2         Ready     Active                          19.03.13
```



h1:
```
$ docker network create --driver overlay --attachable --subnet 10.0.0.0/8 AAAAAA
$ docker service create --replicas 1 --name nginx --network AAAAAA --publish 80:80 nginx
```


dockprom
    https://github.com/stefanprodan/dockprom.git 
        prom/prometheus:v2.23.0
        grafana/grafana:7.3.6
        prom/alertmanager:v0.21.0
        prom/node-exporter:v1.0.1

        gcr.io/cadvisor/cadvisor:v0.38.6
        prom/pushgateway:v1.3.1
        stefanprodan/caddy

swarmprom
    https://github.com/stefanprodan/swarmprom.git 
        stefanprodan/swarmprom-prometheus:v2.5.0
        stefanprodan/swarmprom-grafana:5.3.4
        stefanprodan/swarmprom-alertmanager:v0.14.0
        stefanprodan/swarmprom-node-exporter:v0.16.0

        google/cadvisor
        cloudflare/unsee:v0.8.0
        stefanprodan/caddy

