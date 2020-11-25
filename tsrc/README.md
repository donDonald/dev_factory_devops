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



### 4. Run ansible
```
$ cd ansible
$ ansible-playbook -i hosts -K main.yml
```



#### 5. Shutdown VMs
```
$ vagrant halt
```

