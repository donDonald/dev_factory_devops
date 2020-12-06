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
$ ssh-copy-id -i ansible.ssh.stuff.pub vagrant@ns1
$ ssh-copy-id -i ansible.ssh.stuff.pub vagrant@db1
$ ssh-copy-id -i ansible.ssh.stuff.pub vagrant@app-server1
```
Use "vagrant" as password



#### 2.3 Ensure all VMs can be sshed into with no passwrd requets
```
$ ssh vagrant@ns1
$ ssh vagrant@db1
$ ssh vagrant@app-server1
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

