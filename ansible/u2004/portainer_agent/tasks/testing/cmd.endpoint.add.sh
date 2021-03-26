##!/bin/bash

#    http --form POST :9000/api/endpoints \
#   "Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwidXNlcm5hbWUiOiJhZG1pbiIsInJvbGUiOjEsImV4cCI6MTQ5OTM3NjE1NH0.NJ6vE8FY1WG6jsRQzfMqeatJ4vh2TWAeeYfDhP71YEE" \
#   Name="test-remote" URL="tcp://10.0.7.10:2375" EndpointCreationType=1


# !!!!!!!!!!!!!!!!!!!!! https://github.com/portainer/portainer/issues/4602: The EndpointType parameter has been renamed to EndpointCreationType recently.
# curl -vvv -X POST http://localhost:9000/api/endpoints -H "accept: application/json" -H "Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwidXNlcm5hbWUiOiJhZG1pbiIsInJvbGUiOjEsImV4cCI6MTYxNjgxMzc3NH0.WYF-MlT8w4TRPFl2iaiADXQjXWsup0FQoLDERQJ56AQ" -F "Name=h2" -F "URL=tcp://192.168.200.100:9001" -F "EndpointCreationType=2"



 http --form POST :9000/api/endpoints \
"Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwidXNlcm5hbWUiOiJhZG1pbiIsInJvbGUiOjEsImV4cCI6MTYxNjg4NzEyMX0.vH_ob85VUYjdz4h8r5tw2pmDTLkyuq22jG9Q8fRokdo" \
Name="test-remote" URL="tcp://192.168.200.100:9001" EndpointCreationType=2

#curl -vvv -X POST http://localhost:9000/api/endpoints -H "accept: application/json" -H "Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwidXNlcm5hbWUiOiJhZG1pbiIsInJvbGUiOjEsImV4cCI6MTYxNjg2NTI3OX0.P7OX6YScd7IOS8z0cdscomibEJ7dJGayFV9it4bozG4" -F "Name=h2" -F "URL=tcp://192.168.200.100:9001" -F "EndpointCreationType=2"

