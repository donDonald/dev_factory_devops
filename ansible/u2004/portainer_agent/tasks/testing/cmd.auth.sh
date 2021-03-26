##!/bin/bash

curl -X POST -d "$(cat cmd.admin.create.json)" http://localhost:9000/api/auth
#{"jwt":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwidXNlcm5hbWUiOiJhZG1pbiIsInJvbGUiOjEsImV4cCI6MTYxNjg2NTI3OX0.P7OX6YScd7IOS8z0cdscomibEJ7dJGayFV9it4bozG4"}
