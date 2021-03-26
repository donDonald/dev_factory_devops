##!/bin/bash

curl -X POST -d "$(cat cmd.admin.create.json)" http://localhost:9000/api/users/admin/init
#{"Id":1,"Username":"admin","Password":"$2a$10$4H9BsNPgqLmV7we5XiYsY.v5FPTUFlWzwXm4/uB7yM6GChGrjgCDe","Role":1,"PortainerAuthorizations":null,"EndpointAuthorizations":null}
#{"Id":1,"Username":"admin","Password":"$2a$10$VF58nC5/./a38BnEtzOFj.xiB/WPMPn6W/H0lnZ4WgRGe6CM1Qqk.","Role":1,"PortainerAuthorizations":null,"EndpointAuthorizations":null}
