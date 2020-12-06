# Test
This test runs 3 VMs:
 - dns server
 - postgers + pgadmin
 - simple server

The whole setup is pretty much close to real production environment.\
For VM management I use Vagrant.\
For devops management I use ansible.



### 1. Launch VMs
```
$ vagrant up
```



### 2. Copy ssh keys to VMs
```
$ ssh-copy-id -i ~/.ssh/<identity>.pub vagrant@ns1
$ ssh-copy-id -i ~/.ssh/<identity>.pub vagrant@db1
$ ssh-copy-id -i ~/.ssh/<identity>.pub vagrant@app-server1
```



### 3. Ensure all VMs can be sshed into with no passwrd requets
```
$ ssh vagrant@ns1
$ ssh vagrant@db1
$ ssh vagrant@app-server1
```



### 4. Setup VMs by running ansible
```
$ cd ansible
$ ansible-playbook -i hosts -K main.yml
```
Ansible will ask "BECOME" password - use "vagrant"



### 5. Check app is working in swarm mode
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



#### 6. Shutdown VMs
```
$ vagrant halt
```

